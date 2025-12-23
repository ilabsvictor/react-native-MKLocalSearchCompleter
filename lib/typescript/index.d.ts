export type AddressDetails = {
    title: string;
    coordinate: {
        latitude: number;
        longitude: number;
    };
    region: {
        longitude: number;
        latitude: number;
        longitudeDelta: number;
        latitudeDelta: number;
    };
};
export type ReverseGeocodeResult = {
    name?: string | null;
    thoroughfare?: string | null;
    subThoroughfare?: string | null;
    locality?: string | null;
    subLocality?: string | null;
    administrativeArea?: string | null;
    subAdministrativeArea?: string | null;
    postalCode?: string | null;
    isoCountryCode?: string | null;
    country?: string | null;
    inlandWater?: string | null;
    ocean?: string | null;
    areasOfInterest?: string[] | null;
};
declare class AddressAutocomplete {
    static getAddressDetails: (address: string) => Promise<AddressDetails>;
    static getAddressSuggestions: (address: string) => Promise<Array<{ title: string; subtitle: string }>>;
    static reverseGeocodeLocation: (longitude: number, latitude: number) => Promise<ReverseGeocodeResult>;
}
export default AddressAutocomplete;
