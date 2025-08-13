import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_config.dart';
import '../../core/di/injection_container.dart' as di;
import '../routes/app_router.dart';
import '../theme/app_theme.dart';

/// Aplicación principal de Colmax
class ColmaxApp extends StatelessWidget {
  const ColmaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0, // Evita que el texto se escale automáticamente
            ),
            child: child!,
          );
        },
      );
  }
}