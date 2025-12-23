# Credits to the original author davx1992
This package is based on `react-native-MKLocalSearchCompleter` package by davx1992.
This is a fixed version of `react-native-MKLocalSearchCompleter`, with bug fixes for `getAddressDetails()` would return incorrect coordinates for detailed address suggestions.

# react-native-MKLocalSearchCompleter IOS Only
This module uses MKLocalSearchCompleter Class in IOS, to provide suggestions to user entered address.
This is an free-of-charge alternative to Google Places API.

## Installation

```sh
npm install react-native-MKLocalSearchCompleter
cd ios
pod install
```

## Usage

```js
import AddressAutocomplete from 'react-native-MKLocalSearchCompleter';

// ...

const suggestions = await AddressAutocomplete.getAddressSuggestions('New York');
console.log(suggestions);
// string[]

const details = await AddressAutocomplete.getAddressDetails('New York');
console.log(details);
// {
//   title: string;
//   coordinate: {
//     latitude: number;
//     longitude: number;
//   };
//   region: {
//     longitude: number;
//     latitude: number;
//     longitudeDelta: number;
//     latitudeDelta: number;
//   };
// };

const reverseGeocodeResult = await AddressAutocomplete.reverseGeocodeLocation(22.16887, 52.12333);
console.log(reverseGeocodeResult);
// {
//   name?: string | null;
//   thoroughfare?: string | null;
//   subThoroughfare?: string | null;
//   locality?: string | null;
//   subLocality?: string | null;
//   administrativeArea?: string | null;
//   subAdministrativeArea?: string | null;
//   postalCode?: string | null;
//   ISOcountryCode?: string | null;
//   country?: string | null;
//   inlandWater?: string | null;
//   ocean?: string | null;
//   areasOfInterest?: string[] | null;
// };
```

You should fetch details, using string from suggestion on touch, as details will return only one result.

## License
MIT
