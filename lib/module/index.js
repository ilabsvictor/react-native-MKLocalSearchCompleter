function _defineProperty(e, r, t) { return (r = _toPropertyKey(r)) in e ? Object.defineProperty(e, r, { value: t, enumerable: !0, configurable: !0, writable: !0 }) : e[r] = t, e; }
function _toPropertyKey(t) { var i = _toPrimitive(t, "string"); return "symbol" == typeof i ? i : i + ""; }
function _toPrimitive(t, r) { if ("object" != typeof t || !t) return t; var e = t[Symbol.toPrimitive]; if (void 0 !== e) { var i = e.call(t, r || "default"); if ("object" != typeof i) return i; throw new TypeError("@@toPrimitive must return a primitive value."); } return ("string" === r ? String : Number)(t); }
import { NativeModules, Platform } from 'react-native';
const NativeAddressAutocomplete = NativeModules.AddressAutocomplete;
const NativeGeocode = NativeModules.ReverseGeocode;
class AddressAutocomplete {}
_defineProperty(AddressAutocomplete, "getAddressDetails", async address => {
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