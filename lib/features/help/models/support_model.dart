// lib/features/help/models/support_model.dart
class SupportDetailContent {
  final String question;
  final String introText;
  final List<SupportStep> steps;
  final List<String> statuses;
  final String footerNote;

  SupportDetailContent({
    required this.question,
    required this.introText,
    required this.steps,
    required this.statuses,
    required this.footerNote,
  });
}

class SupportStep {
  final String title;
  final String description;

  SupportStep({required this.title, required this.description});
}
