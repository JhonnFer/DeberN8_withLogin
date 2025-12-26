# 📱 App de Pedidos de Comida Rápida - Integración Supabase + Autenticación

Una aplicación completa de pedidos de comida rápida con autenticación segura, CRUD integrado y gestión de pedidos en tiempo real.

## ✨ Características Principales

### 🔐 Autenticación

- ✅ Login con email/contraseña
- ✅ Registro de nuevos usuarios
- ✅ Restablecimiento de contraseña por email (Supabase)
- ✅ Tokens JWT seguros
- ✅ Row Level Security (RLS)

### 🍔 Gestión de Menú

- ✅ Cargar items de menú desde Supabase
- ✅ Búsqueda y filtrado en tiempo real
- ✅ Categorías de productos
- ✅ Disponibilidad de items

### 🛒 Carrito de Compras

- ✅ Agregar/eliminar items
- ✅ Modificar cantidades
- ✅ Cálculo automático de totales
- ✅ Persistencia de estado con Riverpod

### 📦 Gestión de Pedidos (CRUD Completo)

- ✅ **CREATE**: Crear nuevos pedidos
- ✅ **READ**: Ver mis pedidos
- ✅ **UPDATE**: Cambiar estado de pedido
- ✅ **DELETE**: Cancelar pedidos pendientes

### 🚚 Opciones de Entrega

- ✅ Entrega a domicilio
- ✅ Recogida en tienda
- ✅ Ingreso de dirección personalizada
- ✅ Notas especiales

### 👤 Perfil de Usuario

- ✅ Visualizar datos de perfil
- ✅ Historial de pedidos
- ✅ Información de contacto

---

## 🛠️ Stack Tecnológico

### Frontend

- **Flutter 3.6.0+** - Framework multiplataforma
- **Riverpod 2.0** - State management
- **Go Router** - Navigation routing
- **Supabase Flutter** - Backend as a service

### Backend

- **Supabase** - PostgreSQL + Auth + Storage
- **Row Level Security (RLS)** - Seguridad de datos
- **PostgreSQL Triggers** - Cálculos automáticos

### Arquitectura

```
lib/
├── main.dart                          # Punto de entrada
├── config/
│   └── supabase_config.dart          # Configuración Supabase
├── services/
│   └── supabase_service.dart         # Servicio de Supabase
├── providers/
│   ├── auth_provider.dart            # Autenticación + Estado
│   └── order_provider.dart           # Pedidos + Carrito
├── funciones/
│   ├── auth/
│   │   └── pantallas/
│   │       ├── login_screen.dart
│   │       ├── signup_screen.dart
│   │       └── forgot_password_screen.dart
│   └── pedidos/
│       ├── models/
│       │   ├── food_item_model.dart
│       │   ├── user_model.dart
│       │   └── order_model.dart
│       └── pantallas/
│           ├── home_screen_new.dart  # Menú principal
│           └── orders_screen.dart    # Mis pedidos
├── globales/
│   ├── tema/
│   └── widgets/
└── rutas/
    └── go_router_config.dart         # Configuración de rutas
```

---

## 🚀 Inicio Rápido

### 1️⃣ Requisitos Previos

```bash
# Versiones mínimas requeridas
Flutter: 3.6.0+
Dart: 3.0.0+
```

### 2️⃣ Crear Proyecto en Supabase

1. Ve a [supabase.com](https://supabase.com)
2. Crea un nuevo proyecto
3. Ve a **SQL Editor** y ejecuta el archivo `SETUP_SUPABASE.sql`
4. Obtén credenciales en **Settings → API**

### 3️⃣ Configurar Credenciales

Edita `lib/config/supabase_config.dart`:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://TU_URL.supabase.co';
  static const String supabaseAnonKey = 'TU_CLAVE';
}
```

### 4️⃣ Instalar Dependencias

```bash
flutter pub get
```

### 5️⃣ Ejecutar la App

```bash
flutter run
```

---

## 📱 Guía de Uso

### Primera vez (Nuevo Usuario)

1. **Registro**

   ```
   Pantalla → "Regístrate"
   Email: usuario@example.com
   Contraseña: minimo6caracteres
   ```

2. **Explorar Menú**

   ```
   Después de login, verás items de comida
   Haz tap en un item para ver detalles
   ```

3. **Crear Pedido**

   ```
   Agregar items al carrito
   Especificar dirección (si es entrega)
   Confirmar pedido
   ```

4. **Ver Pedidos**
   ```
   Menú lateral → "Mis Pedidos"
   O icono en top-right
   ```

### Recuperar Contraseña

```
Login → "¿Olvidaste tu contraseña?"
Ingresa tu email
Recibir enlace por email
Crear nueva contraseña
```

---

## 🗄️ Estructura de Base de Datos

### Tablas Principales

#### `users`

```sql
id (UUID) - Primary key
email (VARCHAR)
nombre (VARCHAR)
apellido (VARCHAR)
telefono (VARCHAR)
direccion (TEXT)
ciudad (VARCHAR)
created_at (TIMESTAMP)
```

#### `food_items`

```sql
id (SERIAL) - Primary key
nombre (VARCHAR)
descripcion (TEXT)
precio (DECIMAL)
imagen (VARCHAR)
categoria (VARCHAR)
disponible (BOOLEAN)
created_at (TIMESTAMP)
```

#### `orders`

```sql
id (SERIAL) - Primary key
user_id (UUID) - Foreign key → users.id
estado (VARCHAR) - 'pending', 'completed', 'cancelled'
total (DECIMAL)
entrega_domicilio (BOOLEAN)
direccion_entrega (TEXT)
notas (TEXT)
created_at (TIMESTAMP)
```

#### `order_items`

```sql
id (SERIAL) - Primary key
order_id (INTEGER) - Foreign key → orders.id
food_item_id (INTEGER) - Foreign key → food_items.id
cantidad (INTEGER)
precio (DECIMAL)
notas (TEXT)
created_at (TIMESTAMP)
```

---

## 🔑 Características de Seguridad

### Row Level Security (RLS)

- **Users**: Solo ven sus propios datos
- **Orders**: Solo ven sus propios pedidos
- **Food Items**: Todos pueden leer (público)
- **Order Items**: Solo acceso a items de sus pedidos

### Autenticación

- JWT tokens de Supabase
- Contraseñas encriptadas en BD
- No se almacenan en la app

---

## 🔄 Flujo de Autenticación

```
┌─────────────────────────────────────────┐
│  App Usuario                            │
├─────────────────────────────────────────┤
│                                         │
│  ┌─────────────────────────────────┐   │
│  │ 1. Usuario ingresa email/pass   │   │
│  │    → SupabaseService.signIn()   │   │
│  └────────────┬────────────────────┘   │
│               │                        │
│  ┌────────────▼────────────────────┐   │
│  │ 2. Supabase Auth                │   │
│  │    Valida credenciales          │   │
│  │    Genera JWT token             │   │
│  └────────────┬────────────────────┘   │
│               │                        │
│  ┌────────────▼────────────────────┐   │
│  │ 3. Token guardado en sesión     │   │
│  │    CurrentUserProvider           │   │
│  └────────────┬────────────────────┘   │
│               │                        │
│  ┌────────────▼────────────────────┐   │
│  │ 4. Go Router redirige a Home    │   │
│  │    Usuario autenticado ✓         │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
```

---

## 🚀 Deployment

### Android

```bash
flutter build apk
# APK en: build/app/outputs/flutter-apk/app-release.apk
```

### iOS

```bash
flutter build ios
# Luego upload a App Store
```

### Web

```bash
flutter build web
# Deployment en Firebase Hosting o Vercel
```

### Consideraciones Producción

- ✅ Usar variables de entorno para credenciales
- ✅ No commitear credenciales en GitHub
- ✅ Habilitar CORS en Supabase si es necesario
- ✅ Backup regular de base de datos

---

## 📚 Documentación Adicional

- **[GUIA_SETUP.md](GUIA_SETUP.md)** - Setup paso a paso
- **[SETUP_SUPABASE.sql](SETUP_SUPABASE.sql)** - SQL para base de datos
- **[RAILWAY_VERCEL_SETUP.md](RAILWAY_VERCEL_SETUP.md)** - Backend alternativo

---

## 🐛 Solución de Problemas

### "Connection refused"

→ Verifica URL de Supabase en `supabase_config.dart`

### "Invalid API key"

→ Usa la **Anon Key**, no la Service Role Key

### "No aparecen items de comida"

→ Verifica que ejecutaste `SETUP_SUPABASE.sql`

### "Error al resetear contraseña"

→ Verifica configuración de email en Supabase

---

## 📈 Próximas Mejoras

- [ ] Autenticación con Google/GitHub
- [ ] Integración de pagos (Stripe, PayPal)
- [ ] Sistema de reviews y ratings
- [ ] Notificaciones push en tiempo real
- [ ] Dashboard de admin
- [ ] Generación de reportes
- [ ] Historial de transacciones

---

## 📝 Licencia

MIT License - Libre para uso educativo y comercial

---

## 👨‍💻 Autor

Desarrollado para clase de Desarrollo Móvil
**Tarea N°6 - Integración Supabase + Autenticación**

---

## 💡 Contacto y Soporte

Para dudas o errores:

1. Revisa [GUIA_SETUP.md](GUIA_SETUP.md)
2. Verifica logs en terminal Flutter
3. Consulta documentación de Supabase

**¡Listo para usar!** 🎉
