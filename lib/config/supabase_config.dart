import 'package:flutter_dotenv/flutter_dotenv.dart';

// CONFIGURACIÓN DE SUPABASE
// Lee las credenciales del archivo .env

class SupabaseConfig {
  // Tu URL de Supabase - Lee del .env
  static String get supabaseUrl {
    final url = dotenv.env['SUPABASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception(
        'SUPABASE_URL no está configurado en .env. '
        'Copia .env.example a .env y llena los valores.',
      );
    }
    return url;
  }

  // Tu clave pública de Supabase (ANON KEY) - Lee del .env
  static String get supabaseAnonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'SUPABASE_ANON_KEY no está configurado en .env. '
        'Copia .env.example a .env y llena los valores.',
      );
    }
    return key;
  }

  // Railway API Key (Opcional)
  static String? get railwayApiKey => dotenv.env['RAILWAY_API_KEY'];

  // Railway Email Service URL (Opcional)
  static String? get railwayEmailServiceUrl =>
      dotenv.env['RAILWAY_EMAIL_SERVICE_URL'];

  // App Environment
  static String get appEnv => dotenv.env['APP_ENV'] ?? 'development';

  // Debug Mode
  static bool get debugMode =>
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
}
