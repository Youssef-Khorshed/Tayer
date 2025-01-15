import 'package:takeed/Features/BottomNavigation/Home/Data/Model/create_flight_order/address.dart';
import 'package:takeed/Features/BottomNavigation/Home/Data/Model/flight_offer_from_pricing/flight_offer_from_pricing.dart';
import 'package:takeed/Features/BottomNavigation/Home/Data/Model/get_flight_offers/get_flight_offers.dart';
import 'package:takeed/Features/BottomNavigation/Home/Data/Model/traveller/traveller.dart';

class Appstrings {
  static String kToken = '';

  static String baseUrl =
      'https://api.takeed.co/api/v1/air'; // https://takeed.runasp.net/api/v1/air
  static String airPortsSuggestions({required String keyword}) =>
      '$baseUrl/utilities/airport-city-localized-search-by-keyword?keyword=$keyword';

  static String searchFlights(
          {required String originLocationCode,
          required String destinationLocationCode,
          required String departureDate,
          required String returnDate,
          required String adults,
          required String currencyCode,
          required String children,
          required String infants,
          required String max}) =>
      '$baseUrl/search_and_shopping/get-flight-offers?OriginLocationCode=$originLocationCode&DestinationLocationCode=$destinationLocationCode&DepartureDate=$departureDate&Adults=$adults&CurrencyCode=$currencyCode&travelClass=ECONOMY&ReturnDate=$returnDate&Children=$children&Infants=$infants&max=$max';

  static String flightOfferPricing =
      '$baseUrl/search_and_shopping/post-flight-offers-pricing';

  static List<Map<String, dynamic>> flightOfferPricingBody(
          {required GetFlightOffers flight}) =>
      [flight.toJson()];

  static String createFilghordertUrl = '$baseUrl/booking/flight-create-orders';

  static Map<String, dynamic> createFilghtBody({
    required FlightOfferFromPricing flightRequest,
    required List<Traveller> travelers,
    required Address address,
  }) =>
      {
        "data": {
          "type": "flight-order",
          "flightOffers": flightRequest.flightOffers!
              .map(((element) => element.toJson()))
              .toList(),
          "travelers": travelers.map(((element) => element.toJson())).toList(),
          "remarks": {
            "general": [
              {
                "subType": "GENERAL_MISCELLANEOUS",
                "text": "ONLINE BOOKING FROM INCREIBLE VIAJES"
              }
            ]
          },
          "ticketingAgreement": {"option": "DELAY_TO_CANCEL", "delay": "6D"},
          "contacts": [
            {
              "addresseeName": {"firstName": "PABLO", "lastName": "RODRIGUEZ"},
              "companyName": "INCREIBLE VIAJES",
              "purpose": "STANDARD",
              "phones": [
                {
                  "deviceType": "LANDLINE",
                  "countryCallingCode": "34",
                  "number": "480080071"
                },
                {
                  "deviceType": "MOBILE",
                  "countryCallingCode": "33",
                  "number": "480080072"
                }
              ],
              "emailAddress": "support@increibleviajes.es",
              "address": {
                "lines": ["Calle Prado, 16"],
                "postalCode": "28014",
                "cityName": "Madrid",
                "countryCode": "ES"
              }
            }
          ],
          "formOfPayments": [
            {
              "creditCard": {
                "brand": "EASYPAY",
                "number": "5164700100000005",
                "expiryDate": "2025-01",
                "flightOfferIds": [flightRequest.flightOffers!.first.id]
              }
            }
          ]
        }
      };
}
