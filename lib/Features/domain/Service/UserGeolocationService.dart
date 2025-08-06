import 'package:dio/dio.dart';

import '../Model/GeolocationData.dart';

class UserGeolocationService {
  Future<GeolocationData?> getCountryCodeFromIp() async {
    const String apiUrl = 'http://ip-api.com/json';

    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        if (data['status'] == 'success') {
          // Extract both countryCode and city
          final String? countryCode = data['countryCode'] as String?;
          final String? city = data['city'] as String?;

          // Return an instance of your custom class
          return GeolocationData(
            countryCode: countryCode,
            city: city,
          );
        } else {
          print('IP Geolocation API error: ${data['message']}');
          return null; // Return null if API status is not 'success'
        }
      } else {
        print('Failed to load IP geolocation data: ${response.statusCode}');
        return null; // Return null on non-200 status codes
      }
    } catch (e) {
      print('Exception during IP geolocation request: $e');
      return null; // Return null on any exception
    }
  }
}