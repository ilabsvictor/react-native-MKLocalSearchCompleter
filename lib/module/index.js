function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

import { NativeModules, Platform } from 'react-native';
const NativeAddressAutocomplete = NativeModules.AddressAutocomplete;
const NativeGeocode = NativeModules.ReverseGeocode;

class AddressAutocomplete {}

_defineProperty(AddressAutocomplete, "getAddressDetails", async (address) => {
  const promise = new Promise(async (resolve, reject) => {
    if (Platform.OS === 'android') {
      reject('Only IOs supported.');
    }

    if (address.length > 0) {
      try {
        const details = await NativeAddressAutocomplete.getAddressDetails(address);
        resolve(details);
      } catch (err) {
        reject(err);
      }
    } else {
      reject('Address length should be greater than 0');
    }
  });
  return promise;
});

_defineProperty(AddressAutocomplete, "getAddressSuggestions", async address => {
  const promise = new Promise(async (resolve, reject) => {
    if (Platform.OS === 'android') {
      reject('Only IOs supported.');
    }

    if (address.length > 0) {
      try {
        const suggestions = await NativeAddressAutocomplete.getAddressSuggestions(address);
        resolve(suggestions);
      } catch (err) {
        reject(err);
      }
    } else {
      reject('Address length should be greater than 0');
    }
  });
  return promise;
});

_defineProperty(AddressAutocomplete, "reverseGeocodeLocation", async (longitude, latitude) => {
  const promise = new Promise(async (resolve, reject) => {
    if (Platform.OS === 'android') {
      reject('Only IOs supported.');
    }

    if (latitude && longitude) {
      try {
        const geocode = await NativeGeocode.reverseGeocodeLocation(longitude, latitude);
        resolve(geocode);
      } catch (err) {
        reject(err);
      }
    } else {
      reject('No latitude or longitude provided');
    }
  });
  return promise;
});

export default AddressAutocomplete;
//# sourceMappingURL=index.js.map