import 'package:dio/dio.dart';

import '../Model/GeolocationData.dart';

class UserGeolocationService {
  Future<GeolocationData?> getCountryCodeFromIp() async {
    const String apiUrl = 'http://ip-api.com/json';

    try {
      final dio = Dio();
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        if (data['status'] == 'success') {
          final String? countryCode = data['countryCode'] as String?;
          final String? city = data['city'] as String?;

          return GeolocationData(
            countryCode: countryCode,
            city: city,
          );
        } else {
          print('IP Geolocation API error: ${data['message']}');
          return null;
        }
      } else {
        print('Failed to load IP geolocation data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception during IP geolocation request: $e');
      return null;
    }
  }
}