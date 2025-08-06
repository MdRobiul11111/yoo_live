class GeolocationData {
  final String? countryCode;
  final String? city;

  GeolocationData({
    this.countryCode,
    this.city,
  });

  // Optional: Add a toString method for easy printing
  @override
  String toString() {
    return 'GeolocationData(countryCode: $countryCode, city: $city)';
  }
}