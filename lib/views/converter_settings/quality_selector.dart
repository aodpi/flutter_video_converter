import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QualitySelector extends HookWidget {
  final Function(int value) onChanged;
  const QualitySelector({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final bitrate = useState(5000);
    final isManual = useState(false);
    final textController = useTextEditingController(text: '5000');

    return Flexible(
      flex: 1,
      child: Column(
        children: [
          SegmentedButton(
            segments: const [
              ButtonSegment(
                value: 5000,
                label: Text("Low"),
              ),
              ButtonSegment(
                value: 10000,
                label: Text("Mid"),
              ),
              ButtonSegment(
                value: 15000,
                label: Text("High"),
              ),
              ButtonSegment(
                value: 0,
                label: Text('Manual'),
              )
            ],
            showSelectedIcon: false,
            multiSelectionEnabled: false,
            selected: {isManual.value ? 0 : bitrate.value},
            onSelectionChanged: (val) {
              isManual.value = val.first == 0;
              bitrate.value = val.first;
              textController.value =
                  textController.value.copyWith(text: val.first.toString());

              onChanged(bitrate.value);
            },
          ),
          TextField(
            controller: textController,
            enabled: isManual.value,
            onChanged: (value) {
              bitrate.value = int.tryParse(value) ?? 0;
              onChanged(bitrate.value);
            },
          ),
        ],
      ),
    );
  }
}
