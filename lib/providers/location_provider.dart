import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

enum LocationType { hospital, bank, clinic, other }

class LocationModel {
  final String id;
  final String name;
  final String address;
  final String distance;
  final int waitTimeMinutes;
  final LocationType type;
  final bool isOpen;

  LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.waitTimeMinutes,
    required this.type,
    this.isOpen = true,
  });
}

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

// Helper to get formatted type name
extension LocationTypeExtension on LocationType {
  String get displayName {
    switch (this) {
      case LocationType.hospital:
        return 'Hospital';
      case LocationType.bank:
        return 'Bank';
      case LocationType.clinic:
        return 'Clinic';
      case LocationType.other:
        return 'Service';
    }
  }

  IconData get icon {
    switch (this) {
      case LocationType.hospital:
        return Icons.local_hospital;
      case LocationType.bank:
        return Icons.account_balance;
      case LocationType.clinic:
        return Icons.medical_services;
      case LocationType.other:
        return Icons.business;
    }
  }
}
