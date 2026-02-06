import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:servline/core/theme/app_theme.dart';
import 'package:servline/providers/ticket_provider.dart';
import 'package:servline/widgets/app_button.dart';
import 'package:servline/widgets/loading_overlay.dart';

class ScheduleAppointmentScreen extends ConsumerStatefulWidget {
  final String locationId;
  final String locationName;
  final String serviceId;
  final String serviceName;

  const ScheduleAppointmentScreen({
    super.key,
    required this.locationId,
    required this.locationName,
    required this.serviceId,
    required this.serviceName,
  });

  @override
  ConsumerState<ScheduleAppointmentScreen> createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState
    extends ConsumerState<ScheduleAppointmentScreen> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String? _selectedTimeSlot;
  int _headCount = 1;

  // Mock slots for demo
  final List<String> _morningSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
  ];
  final List<String> _afternoonSlots = [
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
  ];

  void _incrementHeadCount() {
    if (_headCount < 10) setState(() => _headCount++);
  }

  void _decrementHeadCount() {
    if (_headCount > 1) setState(() => _headCount--);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTimeSlot = null; // Reset slot
      });
    }
  }

  Future<void> _confirmBooking() async {
    if (_selectedTimeSlot == null) return;

    // Parse time slot to DateTime
    final format = DateFormat('hh:mm a');
    final time = format.parse(_selectedTimeSlot!);
    final scheduledTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      time.hour,
      time.minute,
    );

    final success = await ref
        .read(ticketProvider.notifier)
        .bookAppointment(
          locationId: widget.locationId,
          locationName: widget.locationName,
          serviceId: widget.serviceId,
          serviceName: widget.serviceName,
          scheduledTime: scheduledTime,
          headCount: _headCount,
        );

    if (success && mounted) {
      // Show success dialog or snackbar then go home
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment Scheduled Successfully! 🎉'),
          backgroundColor: AppColors.success,
        ),
      );
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketState = ref.watch(ticketProvider);

    return LoadingOverlay(
      isLoading: ticketState.isLoading,
      message: 'Booking appointment...',
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Book Appointment',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Selector
              Text('Select Date', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              InkWell(
                onTap: () => _selectDate(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        DateFormat('EEEE, MMMM d, y').format(_selectedDate),
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Party Size
              Text('Party Size', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Number of people', style: AppTextStyles.bodyLarge),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          color: _headCount > 1
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          onPressed: _decrementHeadCount,
                        ),
                        SizedBox(
                          width: 40,
                          child: Text(
                            '$_headCount',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h3,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          color: _headCount < 10
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          onPressed: _incrementHeadCount,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Time Slots
              Text('Morning Slots', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              _buildSlotGrid(_morningSlots),

              const SizedBox(height: 24),
              Text('Afternoon Slots', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              _buildSlotGrid(_afternoonSlots),

              const SizedBox(height: 48),

              // Confirm Button
              AppButton(
                text: 'Confirm Booking',
                onPressed: _selectedTimeSlot != null ? _confirmBooking : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlotGrid(List<String> slots) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final isSelected = _selectedTimeSlot == slot;
        return InkWell(
          onTap: () {
            setState(() {
              _selectedTimeSlot = slot;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              slot,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        );
      },
    );
  }
}
