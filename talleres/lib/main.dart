import 'package:flutter/material.dart';
import 'package:talleres/Routes/app_router.dart';
import 'themes/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// IMPORTANTE
import 'package:provider/provider.dart';
import 'provider/task_provider.dart';
import 'services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    debugPrint('Error loading .env file: $e');
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 🔥 Inicializar SQLite + colas + BD (Solo esta línea nueva)
  await TaskService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        title: 'Flutter - UCEVA',
        routerConfig: appRouter,
      ),
    );
  }
}
