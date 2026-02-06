import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class VisitHistoryScreen extends StatelessWidget {
  const VisitHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock History Data
    final historyItems = [
      _HistoryItem(
        name: 'City General Hospital',
        department: 'Cardiology Dept',
        date: 'Oct 31',
        token: 'A-122',
        status: _VisitStatus.completed,
      ),
      _HistoryItem(
        name: 'National Bank',
        department: 'Loan Services',
        date: 'Sep 12',
        token: 'B-13',
        status: _VisitStatus.cancelled,
      ),
      _HistoryItem(
        name: 'City General Hospital',
        department: 'General Physician',
        date: 'Aug 05',
        token: 'A-43',
        status: _VisitStatus.completed,
      ),
      _HistoryItem(
        name: 'Smile Dental Clinic',
        department: 'Orthodontics',
        date: 'Jul 15',
        token: 'D-15',
        status: _VisitStatus.completed,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Visit History',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF1E293B)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: historyItems.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: item.status == _VisitStatus.completed
                        ? const Color(0xFFEFF6FF) // Blue-50
                        : const Color(0xFFFEF2F2), // Red-50
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.status == _VisitStatus.completed
                        ? Icons
                              .local_hospital // Generic icon
                        : Icons.account_balance, // Just mixing it up
                    color: item.status == _VisitStatus.completed
                        ? const Color(0xFF3B82F6) // Blue-500
                        : const Color(0xFFEF4444), // Red-500
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              item.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: const Color(0xFF1E293B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            item.date,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.department,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            item.status == _VisitStatus.completed
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 14,
                            color: item.status == _VisitStatus.completed
                                ? const Color(0xFF10B981) // Green-500
                                : const Color(0xFFEF4444), // Red-500
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.status == _VisitStatus.completed
                                ? 'Completed'
                                : 'Cancelled',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: item.status == _VisitStatus.completed
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9), // Slate-100
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.token,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum _VisitStatus { completed, cancelled }

class _HistoryItem {
  final String name;
  final String department;
  final String date;
  final String token;
  final _VisitStatus status;

  _HistoryItem({
    required this.name,
    required this.department,
    required this.date,
    required this.token,
    required this.status,
  });
}
