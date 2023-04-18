// GoRouter configuration
import 'package:flutter_video_converter/views/converter_settings/converter_settings_page.dart';
import 'package:flutter_video_converter/views/home_page.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes { home, converterSettings }

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/converter_settings/:filePath',
      name: AppRoutes.converterSettings.name,
      builder: (context, state) => ConverterSettingsPage(
        filePath: state.params['filePath']!,
      ),
    )
  ],
);
