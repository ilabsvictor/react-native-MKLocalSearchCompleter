import CoreLocation
import Foundation
import MapKit

@objc(ReverseGeocode)
class ReverseGeocode: NSObject {
    lazy var geocoder = CLGeocoder()
    
    @objc(reverseGeocodeLocation:withLatitude:withResolver:withRejecter:)
        func reverseGeocodeLocation(longitude: NSNumber, latitude: NSNumber , resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
            let location = CLLocation(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees)
            geocoder.reverseGeocodeLocation(location, preferredLocale: Locale.init(identifier: "en_US") , completionHandler: {(placemarks, error) in
                guard let placemarks = placemarks else {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    reject("reverse_geocode", "Unknown error", error)
                    return
                }

                let pm = placemarks[0]
                let addressDetails:[String: Any] = [
                    "name": pm.name,
                    "thoroughfare": pm.thoroughfare,
                    "subThoroughfare": pm.subThoroughfare,
                    "locality": pm.locality,
                    "subLocality": pm.subLocality,
                    "administrativeArea": pm.administrativeArea,
                    "subAdministrativeArea": pm.subAdministrativeArea,
                    "postalCode": pm.postalCode,
                    "ISOcountryCode": pm.ISOcountryCode,
                    "country": pm.country,
                    "inlandWater": pm.inlandWater,
                    "ocean": pm.ocean,
                    "areasOfInterest": pm.areasOfInterest
                ]
                resolve(addressDetails)
            })
                
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
}
