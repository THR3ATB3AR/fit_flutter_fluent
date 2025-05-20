import 'package:fluent_ui/fluent_ui.dart';

class FluentChip extends StatelessWidget {
  final String label;
  const FluentChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: FluentTheme.of(context).cardColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: FluentTheme.of(context).activeColor,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          label,
        ),
      ),
    );
  }
}