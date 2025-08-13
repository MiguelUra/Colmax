/// Configuración principal de la aplicación Colmax
class AppConfig {
  // URLs de Supabase - REEMPLAZAR CON TUS CREDENCIALES REALES
  static const String supabaseUrl = 'https://tedljwemjofhtkptiyon.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRlZGxqd2Vtam9maHRrcHRpeW9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwODgyNzMsImV4cCI6MjA3MDY2NDI3M30.qTwYnZsAEn9LQI_aVwOJguNjl3JXMqLes6m4rv-GShA';
  
  // Configuración de la aplicación
  static const String appName = 'Colmax';
  static const String appVersion = '1.0.0';
  
  // Configuración de geolocalización
  static const double defaultRadius = 3.0; // 3 km de radio
  static const double defaultLatitude = 18.4861; // Santo Domingo
  static const double defaultLongitude = -69.9312;
  
  // Configuración de pagos
  static const double deliveryFee = 50.0; // RD$ 50 por entrega
  static const double priorityDeliveryFee = 100.0; // RD$ 100 por entrega prioritaria
  static const double monthlySubscription = 500.0; // RD$ 500 suscripción mensual
  
  // Configuración de la UI
  static const double borderRadius = 12.0;
  static const double padding = 16.0;
  static const double iconSize = 24.0;
  static const double largeIconSize = 48.0;
  
  // Colores principales
  static const int primaryColorValue = 0xFF2E7D32; // Verde dominicano
  static const int secondaryColorValue = 0xFFFF6B35; // Naranja vibrante
  static const int accentColorValue = 0xFFFFD700; // Dorado
}