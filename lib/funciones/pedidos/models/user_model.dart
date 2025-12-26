class UserModel {
  final String id;
  final String email;
  final String? nombre;
  final String? apellido;
  final String? telefono;
  final String? direccion;
  final String? ciudad;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    this.nombre,
    this.apellido,
    this.telefono,
    this.direccion,
    this.ciudad,
    this.createdAt,
    this.updatedAt,
  });

  /// Convierte de Map a UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      nombre: map['nombre'],
      apellido: map['apellido'],
      telefono: map['telefono'],
      direccion: map['direccion'],
      ciudad: map['ciudad'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  /// Convierte de UserModel a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'direccion': direccion,
      'ciudad': ciudad,
    };
  }

  /// Copiar con cambios
  UserModel copyWith({
    String? id,
    String? email,
    String? nombre,
    String? apellido,
    String? telefono,
    String? direccion,
    String? ciudad,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
      ciudad: ciudad ?? this.ciudad,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, email: $email, nombre: $nombre, apellido: $apellido)';
}
