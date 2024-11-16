import 'package:dio/dio.dart';
import 'package:foodapp/view/screens/cart/location/.evn.dart';
import 'package:foodapp/view/screens/cart/location/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIkey,
        },
      );

      if (response.statusCode == 200) {
        return Directions.fromMap(response.data);
      } else {
        throw Exception('Failed to fetch directions');
      }
    } catch (e) {
      // Handle DioError or other exceptions here
      print('Error fetching directions: $e');
      throw Exception('Failed to fetch directions');
    }
  }
}
