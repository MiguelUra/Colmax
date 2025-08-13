import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Contenedor de inyección de dependencias para la aplicación Colmax
final sl = GetIt.instance;

/// Inicializa todas las dependencias de la aplicación
Future<void> init() async {
  // Servicios externos
  // final supabase = Supabase.instance.client; // Comentado para pruebas
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // sl.registerLazySingleton(() => supabase); // Comentado para pruebas
  sl.registerLazySingleton(() => sharedPreferences);
  
  // TODO: Registrar repositorios, casos de uso y BLoCs cuando se creen
}