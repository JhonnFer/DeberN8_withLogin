class FoodItem {
  final int id;
  final String nombre;
  final double precio;
  final String? descripcion;
  final String? imagen;
  final String? categoria;
  final bool disponible;
  final DateTime? createdAt;

  FoodItem({
    required this.id,
    required this.nombre,
    required this.precio,
    this.descripcion,
    this.imagen,
    this.categoria,
    this.disponible = true,
    this.createdAt,
  });

  /// Convierte de Map a FoodItem
  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'] ?? 0,
      nombre: map['nombre'] ?? '',
      precio: (map['precio'] ?? 0).toDouble(),
      descripcion: map['descripcion'],
      imagen: map['imagen'],
      categoria: map['categoria'],
      disponible: map['disponible'] ?? true,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  /// Convierte de FoodItem a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'descripcion': descripcion,
      'imagen': imagen,
      'categoria': categoria,
      'disponible': disponible,
    };
  }

  /// Copiar con cambios
  FoodItem copyWith({
    int? id,
    String? nombre,
    double? precio,
    String? descripcion,
    String? imagen,
    String? categoria,
    bool? disponible,
    DateTime? createdAt,
  }) {
    return FoodItem(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      descripcion: descripcion ?? this.descripcion,
      imagen: imagen ?? this.imagen,
      categoria: categoria ?? this.categoria,
      disponible: disponible ?? this.disponible,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'FoodItem(id: $id, nombre: $nombre, precio: $precio)';
}
