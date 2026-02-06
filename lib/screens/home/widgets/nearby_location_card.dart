import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servline/models/location.dart';

class NearbyLocationCard extends StatelessWidget {
  final LocationModel location;

  const NearbyLocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: _getTypeColor(location.type),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              location.type.icon,
              color: _getTypeIconColor(location.type),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${location.distance} • ${location.type.displayName}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getWaitTimeColor(
                    location.waitTimeMinutes,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _getWaitTimeText(location.waitTimeMinutes),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getWaitTimeColor(location.waitTimeMinutes),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '(${location.waitTimeMinutes}m)',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: Colors.grey[300]),
        ],
      ),
    );
  }

  Color _getTypeColor(LocationType type) {
    switch (type) {
      case LocationType.hospital:
        return const Color(0xFFFEF2F2); // Red-50
      case LocationType.bank:
        return const Color(0xFFEFF6FF); // Blue-50
      case LocationType.clinic:
        return const Color(0xFFECFDF5); // Emerald-50
      case LocationType.other:
        return const Color(0xFFF1F5F9); // Slate-100
    }
  }

  Color _getTypeIconColor(LocationType type) {
    switch (type) {
      case LocationType.hospital:
        return const Color(0xFFEF4444); // Red-500
      case LocationType.bank:
        return const Color(0xFF3B82F6); // Blue-500
      case LocationType.clinic:
        return const Color(0xFF10B981); // Emerald-500
      case LocationType.other:
        return const Color(0xFF64748B); // Slate-500
    }
  }

  Color _getWaitTimeColor(int minutes) {
    if (minutes < 10) return const Color(0xFF22C55E); // Green
    if (minutes < 30) return const Color(0xFFF59E0B); // Amber
    return const Color(0xFFEF4444); // Red
  }

  String _getWaitTimeText(int minutes) {
    if (minutes < 10) return 'Short Wait';
    if (minutes < 30) return 'Medium Wait';
    return 'Long Wait';
  }
}
