import 'package:fluent_ui/fluent_ui.dart';

class FluentChip extends StatelessWidget {
  final String label;
  const FluentChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Adjusted padding
      decoration: BoxDecoration(
        color: theme.resources.subtleFillColorSecondary, // Using a subtle fill
        borderRadius: BorderRadius.circular(16), // Softer radius
        border: Border.all(
          color: theme.resources.controlStrokeColorDefault, // Standard border
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: theme.typography.caption?.copyWith(
          color: theme.resources.textFillColorSecondary,
        ),
      ),
    );
  }
}
