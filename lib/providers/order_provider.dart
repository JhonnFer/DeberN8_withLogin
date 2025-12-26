import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../funciones/pedidos/models/order_model.dart';
import '../services/supabase_service.dart';
import 'auth_provider.dart';

// Provider para crear un nuevo pedido
final createOrderProvider =
    FutureProvider.family<int, Map<String, dynamic>>((ref, orderData) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  final result = await supabaseService.createOrder(orderData);
  return result['id'] as int;
});

// Provider para actualizar estado del pedido
final updateOrderStatusProvider =
    FutureProvider.family<void, (int, String)>((ref, params) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  await supabaseService.updateOrderStatus(params.$1, params.$2);
});

// Provider para obtener detalles de un pedido
final orderDetailsProvider =
    FutureProvider.family<Order?, int>((ref, orderId) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  final data = await supabaseService.getOrderDetails(orderId);
  return data != null ? Order.fromMap(data) : null;
});

// Provider para carrito de compras (estado local)
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

class CartItem {
  final int foodItemId;
  final String nombre;
  final double precio;
  int cantidad;
  final String? notas;

  CartItem({
    required this.foodItemId,
    required this.nombre,
    required this.precio,
    required this.cantidad,
    this.notas,
  });

  double get subtotal => precio * cantidad;

  CartItem copyWith({
    int? foodItemId,
    String? nombre,
    double? precio,
    int? cantidad,
    String? notas,
  }) {
    return CartItem(
      foodItemId: foodItemId ?? this.foodItemId,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      cantidad: cantidad ?? this.cantidad,
      notas: notas ?? this.notas,
    );
  }
}

class CartState {
  final List<CartItem> items;
  final bool entregaDomicilio;
  final String? direccionEntrega;
  final String? notas;

  CartState({
    this.items = const [],
    this.entregaDomicilio = true,
    this.direccionEntrega,
    this.notas,
  });

  double get total => items.fold(0, (sum, item) => sum + item.subtotal);

  int get totalItems => items.fold(0, (sum, item) => sum + item.cantidad);

  CartState copyWith({
    List<CartItem>? items,
    bool? entregaDomicilio,
    String? direccionEntrega,
    String? notas,
  }) {
    return CartState(
      items: items ?? this.items,
      entregaDomicilio: entregaDomicilio ?? this.entregaDomicilio,
      direccionEntrega: direccionEntrega ?? this.direccionEntrega,
      notas: notas ?? this.notas,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState());

  void addItem(CartItem item) {
    final existingIndex =
        state.items.indexWhere((i) => i.foodItemId == item.foodItemId);

    if (existingIndex != -1) {
      final updatedItems = [...state.items];
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        cantidad: updatedItems[existingIndex].cantidad + item.cantidad,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(items: [...state.items, item]);
    }
  }

  void removeItem(int foodItemId) {
    state = state.copyWith(
      items:
          state.items.where((item) => item.foodItemId != foodItemId).toList(),
    );
  }

  void updateQuantity(int foodItemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeItem(foodItemId);
      return;
    }

    final updatedItems = state.items.map((item) {
      return item.foodItemId == foodItemId
          ? item.copyWith(cantidad: newQuantity)
          : item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void setDeliveryInfo(
      bool entregaDomicilio, String? direccion, String? notas) {
    state = state.copyWith(
      entregaDomicilio: entregaDomicilio,
      direccionEntrega: direccion,
      notas: notas,
    );
  }

  void clearCart() {
    state = CartState(
      entregaDomicilio: state.entregaDomicilio,
      direccionEntrega: state.direccionEntrega,
      notas: state.notas,
    );
  }

  void reset() {
    state = CartState();
  }
}
