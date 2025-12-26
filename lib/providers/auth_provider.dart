import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

// Provider para el servicio de Supabase
final supabaseServiceProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});

// Provider para el usuario actual
final currentUserProvider = StreamProvider<User?>((ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return supabaseService.authStateChanges().map((event) => event.session?.user);
});

// Provider para el estado de autenticación
final authStateProvider = StreamProvider<AuthState>((ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return supabaseService.authStateChanges();
});

// Provider para controlar el estado de login
final loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return LoginStateNotifier(supabaseService);
});

// Provider para los items del menú
final foodItemsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  return await supabaseService.getAllFoodItems();
});

// Provider para los pedidos del usuario actual
final userOrdersProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) async {
      if (user == null) return [];
      return await supabaseService.getUserOrders(user.id);
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// Clase para manejar el estado del login
class LoginState {
  final bool isLoading;
  final String? error;
  final bool isSuccess;

  LoginState({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// Notifier para manejar el login
class LoginStateNotifier extends StateNotifier<LoginState> {
  final SupabaseService _supabaseService;

  LoginStateNotifier(this._supabaseService) : super(LoginState());

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _supabaseService.signIn(email, password);
      state = state.copyWith(isLoading: false, isSuccess: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al iniciar sesión: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _supabaseService.signUp(email, password);
      state = state.copyWith(isLoading: false, isSuccess: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al registrarse: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _supabaseService.resetPassword(email);
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        error: 'Verificar tu email para restablecer la contraseña',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error: ${e.toString()}',
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _supabaseService.signOut();
      state = LoginState();
    } catch (e) {
      state = state.copyWith(error: 'Error al cerrar sesión: ${e.toString()}');
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
