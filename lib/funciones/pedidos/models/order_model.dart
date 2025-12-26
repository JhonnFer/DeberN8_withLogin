class OrderItem {
  final int id;
  final int orderId;
  final int foodItemId;
  final int cantidad;
  final double precio;
  final String? notas;
  final DateTime? createdAt;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.foodItemId,
    required this.cantidad,
    required this.precio,
    this.notas,
    this.createdAt,
  });

  /// Convierte de Map a OrderItem
  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] ?? 0,
      orderId: map['order_id'] ?? 0,
      foodItemId: map['food_item_id'] ?? 0,
      cantidad: map['cantidad'] ?? 1,
      precio: (map['precio'] ?? 0).toDouble(),
      notas: map['notas'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  /// Convierte de OrderItem a Map
  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'food_item_id': foodItemId,
      'cantidad': cantidad,
      'precio': precio,
      'notas': notas,
    };
  }

  /// Calcular subtotal
  double get subtotal => precio * cantidad;

  @override
  String toString() =>
      'OrderItem(id: $id, cantidad: $cantidad, precio: $precio, subtotal: $subtotal)';
}

class Order {
  final int id;
  final String userId;
  final String estado; // pending, completed, cancelled
  final double total;
  final bool entregaDomicilio;
  final String? direccionEntrega;
  final String? notas;
  final List<OrderItem>? items;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.estado,
    required this.total,
    required this.entregaDomicilio,
    this.direccionEntrega,
    this.notas,
    this.items,
    this.createdAt,
    this.updatedAt,
  });

  /// Convierte de Map a Order
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? '',
      estado: map['estado'] ?? 'pending',
      total: (map['total'] ?? 0).toDouble(),
      entregaDomicilio: map['entrega_domicilio'] ?? true,
      direccionEntrega: map['direccion_entrega'],
      notas: map['notas'],
      items: (map['order_items'] as List?)
          ?.map((item) => OrderItem.fromMap(item))
          .toList(),
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  /// Convierte de Order a Map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'estado': estado,
      'total': total,
      'entrega_domicilio': entregaDomicilio,
      'direccion_entrega': direccionEntrega,
      'notas': notas,
    };
  }

  /// Copiar con cambios
  Order copyWith({
    int? id,
    String? userId,
    String? estado,
    double? total,
    bool? entregaDomicilio,
    String? direccionEntrega,
    String? notas,
    List<OrderItem>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      estado: estado ?? this.estado,
      total: total ?? this.total,
      entregaDomicilio: entregaDomicilio ?? this.entregaDomicilio,
      direccionEntrega: direccionEntrega ?? this.direccionEntrega,
      notas: notas ?? this.notas,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'Order(id: $id, userId: $userId, estado: $estado, total: $total)';
}
