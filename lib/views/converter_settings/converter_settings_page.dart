import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_video_converter/views/converter_settings/quality_selector.dart';

class ConverterSettingsPage extends HookWidget {
  const ConverterSettingsPage({super.key, required this.filePath});

  final String filePath;
  @override
  Widget build(BuildContext context) {
    var memoized = useMemoized(() => getDuration(filePath));
    var info = useFuture(memoized);
    var bitrate = useState(5000);
    var isInProgress = useState(false);
    var estimate = calculateFileSizeInBytes(info.data!, bitrate.value);

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
                Text(
                  "Profile:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  info.data.toString(),
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
                  onPressed: () async {
                    final result = await FilePicker.platform.saveFile(
                      type: FileType.video,
                      fileName: Uri.file(filePath).pathSegments.last,
                    );
                    isInProgress.value = true;
                    if (result != null) {
                      await saveFile(filePath, result, bitrate.value);
                    }
                    isInProgress.value = false;
                  },
                  child: Text('Save as ...'),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QualitySelector(
                  onChanged: (value) {
                    bitrate.value = value;
                  },
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Estimate: $estimate megabytes")],
            ),
            const SizedBox(height: 20),
            if (isInProgress.value)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
          ],
        ),
      ),
    );
  }
}

Future<int> saveFile(
  String inputFilePath,
  String outputFilePath,
  int bitRate,
) async {
  var processResult = await Process.run('assets/ffmpeg', [
    '-y',
    '-i',
    inputFilePath,
    '-c:v',
    'hevc_nvenc',
    '-b:v',
    '${bitRate}K',
    '-c:a',
    'aac',
    outputFilePath,
  ]);

  print(processResult.stdout.toString());

  if (processResult.exitCode != 0) {
    print(processResult.stderr.toString());
  }

  return processResult.exitCode;
}

Future<int> getDuration(String inputFilePath) async {
  var processResult = await Process.run('assets/ffmpeg', ['-i', inputFilePath]);
  var output = processResult.stderr.toString();

  var durationMatch =
      RegExp(r"Duration: (\d{2}):(\d{2}):(\d{2})").firstMatch(output);
  var durationInSeconds = 0;
  if (durationMatch != null) {
    var hours = int.parse(durationMatch.group(1)!);
    var minutes = int.parse(durationMatch.group(2)!);
    var seconds = int.parse(durationMatch.group(3)!);
    durationInSeconds = hours * 3600 + minutes * 60 + seconds;
  }

  return durationInSeconds;
}

String calculateFileSizeInBytes(int durationInSeconds, int bitrateInKbps) {
  var videoBitrate = bitrateInKbps * 1000;
  var audioBitrate = 128000; // 128 kbps
  var totalBitrate = videoBitrate + audioBitrate;
  var fileSizeInBits = totalBitrate * durationInSeconds;
  var fileSizeInBytes = fileSizeInBits ~/ 8;
  return (fileSizeInBytes / 1000 / 1000).toStringAsFixed(2);
}
