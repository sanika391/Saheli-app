import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>?> makeSafeRouteRequest(LatLng source, LatLng destination, String mode) async {
  final url = Uri.parse('https://saheli-backend-ufs3.onrender.com/safest-route');

  print('Source: $source');
  print('Destination: $destination');
  print('Mode: $mode');

  final response = await http.post(
    url,
    body: jsonEncode({
      'source': {
        'lat': source.latitude,
        'lng': source.longitude,
      },
      'destination': {
        'lat': destination.latitude,
        'lng': destination.longitude,
      },
      'mode': mode,
    }),
    headers: {'Content-Type': 'application/json'}, // Specify JSON content type
  );

  if (response.statusCode == 200) {
    // Request successful
    final body = jsonDecode(response.body);
    print('Safe route request successful');

    // Extract and return the steps from the response
    return body['safestRoute']['legs'][0]['steps']; // Assuming there's only one leg
  } else {
    // Request failed
    print('Safe route request failed');
    return null; // Return null or handle the error as needed
  }
}