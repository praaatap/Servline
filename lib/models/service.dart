import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as appwrite;

/// Service model for queue services
class ServiceModel {
  final String id;
  final String name;
  final String? description;
  final String locationId;
  final int estimatedWaitMinutes;
  final int currentQueueSize;
  final IconData icon;
  final bool isActive;
  
  const ServiceModel({
    required this.id,
    required this.name,
    this.description,
    required this.locationId,
    required this.estimatedWaitMinutes,
    this.currentQueueSize = 0,
    this.icon = Icons.confirmation_number,
    this.isActive = true,
  });
  
  /// Create ServiceModel from Appwrite Document
  factory ServiceModel.fromDocument(appwrite.Document doc) {
    return ServiceModel(
      id: doc.$id,
      name: doc.data['name'] ?? '',
      description: doc.data['description'],
      locationId: doc.data['locationId'] ?? '',
      estimatedWaitMinutes: doc.data['estimatedWaitMinutes'] ?? 0,
      currentQueueSize: doc.data['currentQueueSize'] ?? 0,
      icon: _iconFromString(doc.data['icon'] ?? 'confirmation_number'),
      isActive: doc.data['isActive'] ?? true,
    );
  }
  
  /// Convert to JSON for Appwrite
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'locationId': locationId,
      'estimatedWaitMinutes': estimatedWaitMinutes,
      'currentQueueSize': currentQueueSize,
      'icon': _iconToString(icon),
      'isActive': isActive,
    };
  }
  
  /// Get formatted wait time
  String get formattedWaitTime {
    if (estimatedWaitMinutes == 0) {
      return 'No wait time';
    } else if (estimatedWaitMinutes < 60) {
      return '$estimatedWaitMinutes min';
    } else {
      final hours = estimatedWaitMinutes ~/ 60;
      final mins = estimatedWaitMinutes % 60;
      return mins > 0 ? '${hours}h ${mins}m' : '${hours}h';
    }
  }
  
  /// Helper to convert icon string to IconData
  static IconData _iconFromString(String iconName) {
    switch (iconName) {
      case 'account_balance':
        return Icons.account_balance;
      case 'attach_money':
        return Icons.attach_money;
      case 'credit_card':
        return Icons.credit_card;
      case 'health_and_safety':
        return Icons.health_and_safety;
      case 'medical_services':
        return Icons.medical_services;
      case 'support_agent':
        return Icons.support_agent;
      case 'help_outline':
        return Icons.help_outline;
      case 'person':
        return Icons.person;
      case 'settings':
        return Icons.settings;
      default:
        return Icons.confirmation_number;
    }
  }
  
  /// Helper to convert IconData to string
  static String _iconToString(IconData icon) {
    if (icon == Icons.account_balance) return 'account_balance';
    if (icon == Icons.attach_money) return 'attach_money';
    if (icon == Icons.credit_card) return 'credit_card';
    if (icon == Icons.health_and_safety) return 'health_and_safety';
    if (icon == Icons.medical_services) return 'medical_services';
    if (icon == Icons.support_agent) return 'support_agent';
    if (icon == Icons.help_outline) return 'help_outline';
    if (icon == Icons.person) return 'person';
    if (icon == Icons.settings) return 'settings';
    return 'confirmation_number';
  }
}
