import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_video_converter/routes.dart';
import 'package:go_router/go_router.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              dialogTitle: "Choose video to convert",
              type: FileType.video,
            );

            if (result != null && context.mounted) {
              context.pushNamed(
                AppRoutes.converterSettings.name,
                params: {
                  'filePath': result.files[0].path!,
                },
              );
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Chose File'),
        ),
      ),
    );
  }
}
