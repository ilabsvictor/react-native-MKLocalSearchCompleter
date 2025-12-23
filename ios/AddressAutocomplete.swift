import MapKit
import Foundation

@objc(AddressAutocomplete)
class AddressAutocomplete: NSObject, MKLocalSearchCompleterDelegate {

    var resolver: RCTPromiseResolveBlock?
    var rejecter: RCTPromiseRejectBlock?
    let completer: MKLocalSearchCompleter = MKLocalSearchCompleter();
    var searchRequest: MKLocalSearch.Request?
    var localSearch: MKLocalSearch?
    var suggestionResults: [MKLocalSearchCompletion] = []

    override init() {
        super.init()
        completer.delegate = self
    }
    
    @objc(getAddressSuggestions:withResolver:withRejecter:)
    func getAddressSuggestions(address: String!, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            if self.completer.isSearching {
                self.completer.cancel()
            }
            self.completer.queryFragment = address
            self.resolver = resolve
            self.rejecter = reject

            if self.completer.isSearching {
                print("Searching" + address) // Prints
            }
        }
    }

    @objc(getAddressDetails:withResolver:withRejecter:)
    func getAddressDetails(address: String!, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            if self.localSearch?.isSearching == true {
                print("Canceling request")
                self.localSearch?.cancel()
            }
            
            // FIXED: Try to find the exact suggestion first
            let matchingSuggestion = self.suggestionResults.first { suggestion in
                let suggestionText = suggestion.title + " " + suggestion.subtitle
                return suggestionText == address
            }
            
            if let suggestion = matchingSuggestion {
                // Use the exact suggestion for search
                self.searchRequest = MKLocalSearch.Request(completion: suggestion)
            } else {
                // Fallback to natural language query
                self.searchRequest = MKLocalSearch.Request()
                self.searchRequest?.naturalLanguageQuery = address
            }
            
            self.localSearch = MKLocalSearch(request: self.searchRequest!);
            
            self.localSearch?.start { (response, error) in
                guard let response = response else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error").")
                    reject("address_autocomplete", "Unknown error", error)
                    return
                }

                let items = response.mapItems;
                
                // FIXED: Find the best matching item instead of always taking the first
                var bestItem = items[0]
                
                if items.count > 1 {
                    // Try to find the item that best matches the requested address
                    for item in items {
                        let itemTitle = item.placemark.title ?? ""
                        if itemTitle.contains(address) || address.contains(itemTitle) {
                            bestItem = item
                            break
                        }
                    }
                }
                
                let details:[String: Any] = [
                    "title": bestItem.placemark.title! as String,
                    "coordinate": [
                        "longitude": bestItem.placemark.coordinate.longitude as Double,
                        "latitude": bestItem.placemark.coordinate.latitude as Double
                    ],
                    "region": [
                        "longitude": response.boundingRegion.center.longitude as Double,
                        "latitude": response.boundingRegion.center.latitude as Double,
                        "latitudeDelta": response.boundingRegion.span.latitudeDelta,
                        "longitudeDelta": response.boundingRegion.span.longitudeDelta
                    ]
                ]
                
                resolve(details)
            }
        }
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // FIXED: Store the suggestion results for later use
        self.suggestionResults = completer.results
        
        let results = completer.results.map { (result) -> [String: String] in
            return [
                "title": result.title,
                "subtitle": result.subtitle
            ]
        }
        self.resolver?(results)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.rejecter?("address_autocomplete", "An error occured", error)
        print(error)
    }

    @objc(multiply:withB:withResolver:withRejecter:)
    func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b)
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
}
