import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_video_converter/views/converter_settings/quality_selector.dart';

class ConverterSettingsPage extends HookWidget {
  const ConverterSettingsPage({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Uri.file(filePath).pathSegments.last,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Profile:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'MP4 File profile',
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Restore defaults'),
                ),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Save as...'),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text(
                  "Quality:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              children: const [QualitySelector()],
            ),
          ],
        ),
      ),
    );
  }
}
