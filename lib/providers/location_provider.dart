import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:servline/models/location.dart';

final nearbyLocationsProvider = Provider<List<LocationModel>>((ref) {
  return [
    LocationModel(
      id: '1',
      name: 'City General Hospital',
      address: '123 Health Ave, Downtown',
      distance: '0.5 mi',
      waitTimeMinutes: 15,
      type: LocationType.hospital,
    ),
    LocationModel(
      id: '2',
      name: 'Chase Bank - Downtown',
      address: '45 Financial St',
      distance: '1.2 mi',
      waitTimeMinutes: 5,
      type: LocationType.bank,
    ),
    LocationModel(
      id: '3',
      name: 'Mercy Clinic',
      address: '78 Wellness Blvd',
      distance: '2.0 mi',
      waitTimeMinutes: 45,
      type: LocationType.clinic,
    ),
    LocationModel(
      id: '4',
      name: 'Dr. Smith\'s Dental',
      address: '90 Smile Road',
      distance: '2.5 mi',
      waitTimeMinutes: 20,
      type: LocationType.clinic,
    ),
  ];
});
