// GoRouter configuration
import 'package:flutter_video_converter/views/converter_settings.dart';
import 'package:flutter_video_converter/views/home.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes { home, converterSettings }

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home.name,
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/converter_settings/:filePath',
      name: AppRoutes.converterSettings.name,
      builder: (context, state) => ConverterSettings(
        filePath: state.params['filePath']!,
      ),
    )
  ],
);
