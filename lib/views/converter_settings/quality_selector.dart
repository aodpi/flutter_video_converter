import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QualitySelector extends HookWidget {
  const QualitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final bitrate = useState(5000);

    return SegmentedButton(
      segments: const [
        ButtonSegment(
          value: 5000,
          label: Text("Low (5000 kbps)"),
        ),
        ButtonSegment(
          value: 10000,
          label: Text("Mid (10000 kbps)"),
        ),
        ButtonSegment(
          value: 15000,
          label: Text("High (15000 kbps)"),
        ),
      ],
      showSelectedIcon: false,
      selected: {bitrate.value},
      multiSelectionEnabled: false,
      onSelectionChanged: (val) {
        bitrate.value = val.first;
      },
    );
  }
}
