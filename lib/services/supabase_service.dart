import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  SupabaseClient get client => Supabase.instance.client;

  /// Obtiene el usuario actual
  User? getCurrentUser() {
    return client.auth.currentUser;
  }

  /// Obtiene la sesión actual
  Session? getCurrentSession() {
    return client.auth.currentSession;
  }

  /// Stream de cambios de autenticación
  Stream<AuthState> authStateChanges() {
    return client.auth.onAuthStateChange;
  }

  // ============= AUTENTICACIÓN =============

  /// Registro con email y contraseña
  Future<AuthResponse> signUp(String email, String password) async {
    return await client.auth.signUp(email: email, password: password);
  }

  /// Login con email y contraseña
  Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth
        .signInWithPassword(email: email, password: password);
  }

  /// Cerrar sesión
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  /// Restablecer contraseña
  Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  /// Actualizar contraseña
  Future<UserResponse> updatePassword(String newPassword) async {
    return await client.auth.updateUser(UserAttributes(password: newPassword));
  }

  // ============= USUARIOS =============

  /// Obtener datos del usuario desde tabla 'users'
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await client
        .from('users')
        .select()
        .eq('id', userId)
        .single()
        .catchError((_) => null);
    return response;
  }

  /// Crear o actualizar perfil de usuario
  Future<void> upsertUserProfile(Map<String, dynamic> userData) async {
    await client.from('users').upsert(userData);
  }

  /// Actualizar perfil de usuario
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    await client.from('users').update(updates).eq('id', userId);
  }

  // ============= COMIDA (MENU ITEMS) =============

  /// Obtener todos los elementos del menú
  Future<List<Map<String, dynamic>>> getAllFoodItems() async {
    return await client.from('food_items').select();
  }

  /// Obtener elemento de comida por ID
  Future<Map<String, dynamic>?> getFoodItem(int id) async {
    final response = await client
        .from('food_items')
        .select()
        .eq('id', id)
        .single()
        .catchError((_) => null);
    return response;
  }

  /// Crear nuevo elemento de comida (admin)
  Future<Map<String, dynamic>> createFoodItem(
      Map<String, dynamic> foodData) async {
    return await client.from('food_items').insert(foodData).select().single();
  }

  /// Actualizar elemento de comida
  Future<void> updateFoodItem(int id, Map<String, dynamic> updates) async {
    await client.from('food_items').update(updates).eq('id', id);
  }

  /// Eliminar elemento de comida
  Future<void> deleteFoodItem(int id) async {
    await client.from('food_items').delete().eq('id', id);
  }

  // ============= PEDIDOS =============

  /// Obtener todos los pedidos del usuario
  Future<List<Map<String, dynamic>>> getUserOrders(String userId) async {
    return await client
        .from('orders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }

  /// Obtener todos los pedidos (admin)
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    return await client.from('orders').select();
  }

  /// Crear nuevo pedido
  Future<Map<String, dynamic>> createOrder(
      Map<String, dynamic> orderData) async {
    return await client.from('orders').insert(orderData).select().single();
  }

  /// Actualizar estado del pedido
  Future<void> updateOrderStatus(int orderId, String status) async {
    await client.from('orders').update({'status': status}).eq('id', orderId);
  }

  /// Obtener detalles de un pedido
  Future<Map<String, dynamic>?> getOrderDetails(int orderId) async {
    final response = await client
        .from('orders')
        .select('*, order_items(*)')
        .eq('id', orderId)
        .single()
        .catchError((_) => null);
    return response;
  }

  /// Crear items del pedido
  Future<void> createOrderItems(List<Map<String, dynamic>> orderItems) async {
    await client.from('order_items').insert(orderItems);
  }

  /// Eliminar pedido
  Future<void> deleteOrder(int orderId) async {
    await client.from('orders').delete().eq('id', orderId);
  }

  // ============= GENERALES =============

  /// Realizar query personalizada
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? select = '*',
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) async {
    var query = client.from(table).select(select ?? '*');

    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }

    if (orderBy != null) {
      query = query.order(orderBy, ascending: ascending)
          as PostgrestFilterBuilder<List<Map<String, dynamic>>>;
    }

    if (limit != null) {
      query = query.limit(limit)
          as PostgrestFilterBuilder<List<Map<String, dynamic>>>;
    }

    return await query;
  }
}
