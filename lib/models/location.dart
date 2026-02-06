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
