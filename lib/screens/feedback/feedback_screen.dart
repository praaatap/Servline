import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servline/core/theme/app_theme.dart';
import 'package:servline/models/feedback.dart';
import 'package:servline/providers/feedback_provider.dart';
import 'package:servline/widgets/app_button.dart';
import 'package:servline/widgets/app_text_field.dart';
import 'package:servline/widgets/rating_widget.dart';

/// Feedback & Rating Screen - as per design screenshot
class FeedbackScreen extends ConsumerWidget {
  final String ticketId;
  final String locationId;

  const FeedbackScreen({
    super.key,
    required this.ticketId,
    required this.locationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(feedbackProvider);
    final feedbackNotifier = ref.read(feedbackProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Service Complete',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.go('/home'),
            child: Text(
              'Skip',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  Text(
                    'How was your wait?',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your feedback helps us improve the waiting\nexperience for everyone.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Rating
            RatingWidget(
              selectedRating: feedbackState.selectedRating,
              onRatingChanged: (rating) => feedbackNotifier.setRating(rating),
            ),

            const SizedBox(height: 40),

            // Notes
            Text(
              'Notes for the staff',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            AppTextField(
              hintText: 'The waiting area was clean and quiet...',
              maxLines: 4,
              onChanged: (value) => feedbackNotifier.setNotes(value),
            ),

            const SizedBox(height: 32),

            // Quick Tags
            Text(
              'QUICK TAGS',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textTertiary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FeedbackTags.positiveTags.map((tag) {
                final isSelected = feedbackState.selectedTags.contains(tag);
                return TagChip(
                  label: tag,
                  isSelected: isSelected,
                  onTap: () => feedbackNotifier.toggleTag(tag),
                );
              }).toList(),
            ),

            const SizedBox(height: 48),

            // Submit Button
            AppButton(
              text: 'Submit Feedback',
              isLoading: feedbackState.isSubmitting,
              onPressed: () async {
                final success = await feedbackNotifier.submitFeedback(
                  ticketId: ticketId,
                  locationId: locationId,
                );

                if (success && context.mounted) {
                  _showSuccessDialog(context);
                }
              },
            ),

            const SizedBox(height: 16),

            // Anonymous note
            Center(
              child: Text(
                'Your feedback is anonymous and secure.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
            ),

            // Error message
            if (feedbackState.error != null) ...[
              const SizedBox(height: 16),
              Center(
                child: Text(
                  feedbackState.error!,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.success,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            Text('Thank You!', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text(
              'Your feedback has been submitted.',
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Done',
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
