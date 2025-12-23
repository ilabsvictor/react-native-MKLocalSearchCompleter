#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AddressAutocomplete, NSObject)
    RCT_EXTERN_METHOD(requiresMainQueueSetup)

    RCT_EXTERN_METHOD(getAddressSuggestions:(NSString)address
                     withResolver:(RCTPromiseResolveBlock)resolve
                     withRejecter:(RCTPromiseRejectBlock)reject)

    RCT_EXTERN_METHOD(getAddressDetails:(NSString)address
                     withResolver:(RCTPromiseResolveBlock)resolve
                     withRejecter:(RCTPromiseRejectBlock)reject)

@end

@interface RCT_EXTERN_MODULE(ReverseGeocode, NSObject)
    RCT_EXTERN_METHOD(requiresMainQueueSetup)

    RCT_EXTERN_METHOD(reverseGeocodeLocation:(nonnull NSNumber)longitude
                     withLatitude:(nonnull NSNumber)latitude
                     withResolver:(RCTPromiseResolveBlock)resolve
                     withRejecter:(RCTPromiseRejectBlock)reject)
@end

