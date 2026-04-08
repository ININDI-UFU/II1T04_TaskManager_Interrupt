import 'package:flutter/material.dart';
import 'screens/presentation_screen.dart';

const kTotalSlides = 30;

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerenciamento de Tarefas – ESP32',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF12131A),
      ),
      initialRoute: '/1',
      onGenerateRoute: (settings) {
        final name = settings.name ?? '/1';
        final idx = int.tryParse(name.replaceAll('/', '')) ?? 1;
        final slideIndex = idx.clamp(1, kTotalSlides);
        return PageRouteBuilder(
          settings: RouteSettings(name: '/$slideIndex'),
          pageBuilder: (_, _, _) =>
              PresentationScreen(initialSlide: slideIndex),
          transitionsBuilder: (_, a, _, child) =>
              FadeTransition(opacity: a, child: child),
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
