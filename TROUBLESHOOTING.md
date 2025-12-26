# 🔧 TROUBLESHOOTING AVANZADO

## 🚨 Problemas Comunes y Soluciones

### 1. ❌ ERRORES DE COMPILACIÓN

#### Error: "supabase_flutter: not found"

**Solución:**

```bash
flutter pub get
flutter pub cache repair
flutter clean
flutter pub get
```

#### Error: "Unresolved reference to 'go_router'"

**Solución:**

```bash
# Actualizar pubspec.yaml
flutter pub get --upgrade
```

#### Error: "ProviderScope not found"

**Solución:**

```bash
# Asegurate de agregar ProviderScope en main.dart
runApp(const ProviderScope(child: MyApp()));
```

---

### 2. ❌ ERRORES DE SUPABASE

#### Error: "Failed to sign in: invalid_grant"

**Causa:** Email o contraseña incorrectos
**Solución:**

```
✓ Verifica que el email esté registrado
✓ Contraseña mínimo 6 caracteres
✓ Sin espacios en blanco
```

#### Error: "Connection timed out"

**Causa:** Problema de red o credenciales incorrectas
**Solución:**

```dart
// En supabase_config.dart, verifica:
// - supabaseUrl: https://tu-id.supabase.co
// - supabaseAnonKey: empieza con "eyJh..."

// Prueba conexión:
// Abre en navegador: https://tu-id.supabase.co
// Deberías ver una página de Supabase
```

#### Error: "Invalid API key"

**Causa:** Usaste Service Role Key en lugar de Anon Key
**Solución:**

```
❌ NO: sk_service_role_abc123...
✅ SÍ: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

En Supabase:
Settings → API → Project API Keys
→ Copia la "anon public" (la más corta)
→ NO la "service_role_secret"
```

#### Error: "RLS violation"

**Causa:** Row Level Security bloqueó el acceso
**Solución:**

```sql
-- En Supabase SQL Editor, verifica las políticas:
SELECT * FROM information_schema.tables
WHERE table_name IN ('users', 'orders', 'order_items', 'food_items');

-- Si ves que RLS está deshabilitado, habilita:
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
```

---

### 3. ❌ PROBLEMAS CON AUTENTICACIÓN

#### Error: "User not found in table 'users'"

**Causa:** El usuario se registró pero no se creó su perfil
**Solución:**

```dart
// En signup_screen.dart, agrega después de signUp:
final supabaseService = SupabaseService();
await supabaseService.upsertUserProfile({
  'id': user.id,
  'email': user.email,
});
```

#### No recibo email de reseteo

**Causa 1:** Email no configurado en Supabase
**Solución:**

```
En Supabase:
1. Authentication → Providers → Email
2. Verifica que esté "Enabled"
3. En "Email Templates", personaliza si quieres
```

**Causa 2:** Email va a spam
**Solución:**

```
✓ Revisa carpeta de Spam
✓ Supabase envía desde noreply@supabase.io
✓ En desarrollo, ve a Auth → Users → el email
✓ Haz clic en el email para ver detalles
```

**Causa 3:** SMTP no configurado
**Solución:**

```
Supabase gratis usa SMTP por defecto
Si no funciona, opción manual:
→ Ver RAILWAY_VERCEL_SETUP.md
→ Configurar backend propio con nodemailer
```

---

### 4. ❌ PROBLEMAS DE BASE DE DATOS

#### Error: "Relation 'users' does not exist"

**Causa:** No ejecutaste el SETUP_SUPABASE.sql
**Solución:**

```
1. Ve a Supabase → SQL Editor
2. Abre SETUP_SUPABASE.sql completo
3. Copia todo el código
4. Pega en el editor SQL
5. Click "Run"
6. Espera a que terminen las queries
```

#### Las tablas existen pero están vacías

**Solución:**

```sql
-- Verificar si hay datos:
SELECT COUNT(*) FROM food_items;
SELECT COUNT(*) FROM users;

-- Si está vacío, inserta datos:
INSERT INTO food_items (nombre, precio, categoria) VALUES
('Hamburguesa', 3.50, 'Hamburguesas'),
('Pizza', 8.00, 'Pizzas');

-- Verifica:
SELECT * FROM food_items;
```

#### Error: "Duplicate key value violates unique constraint"

**Causa:** Intenta insertar un email que ya existe
**Solución:**

```
✓ En Signup, usa un email diferente
✓ Si necesitas verificar emails existentes:

En Supabase Authentication → Users
```

---

### 5. ❌ PROBLEMAS CON RIVERPOD

#### Error: "FutureProvider is loading forever"

**Causa:** Proveedor no tiene datos
**Solución:**

```dart
// Verifica que Supabase devuelva datos:
final foodItemsAsync = ref.watch(foodItemsProvider);

foodItemsAsync.when(
  data: (items) {
    print('Items: ${items.length}'); // Debuguea
    return ListView(...);
  },
  loading: () => CircularProgressIndicator(),
  error: (error, stack) {
    print('Error: $error'); // Ve el error exacto
    return Text('Error: $error');
  }
);
```

#### Error: "Can't read ProviderContainer from context"

**Solución:**

```dart
// Asegurate que TODA la app está en ProviderScope:
// main.dart:
void main() {
  runApp(
    const ProviderScope(  // ← IMPORTANTE
      child: MyApp(),
    ),
  );
}
```

---

### 6. ❌ PROBLEMAS CON GO ROUTER

#### Pantalla en blanco después de login

**Causa:** Redirección infinita
**Solución:**

```dart
// En go_router_config.dart, verifica la lógica:
redirect: (context, state) {
  final isLoggedIn = /* verificación correcta */;
  if (!isLoggedIn && !isAuthRoute) {
    return '/login'; // Redirige a login
  }
  return null; // No redirige
};
```

#### "No route for /unknown"

**Solución:**

```dart
// Agrega todas las rutas en GoRoute:
GoRoute(
  path: '/mi-nueva-ruta',
  builder: (context, state) => MyScreen(),
),
```

---

### 7. ❌ PROBLEMAS DE ESTADO

#### Carrito se pierde al recargar

**Causa:** Riverpod usa memoria, no persistencia
**Solución (Opción 1):**

```dart
// Usar SharedPreferences:
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier()..loadFromStorage();
});
```

**Solución (Opción 2):**

```dart
// Guardar el pedido en Supabase en lugar de solo en estado local
```

#### currentUserProvider siempre es null

**Causa:** Supabase aún no ha iniciado sesión
**Solución:**

```dart
// Espera a que se inicialice:
await Supabase.initialize(...) // En main()

// Luego usa currentUserProvider
```

---

### 8. ❌ PROBLEMAS DE RENDIMIENTO

#### App se congela al cargar muchos items

**Causa:** GridView sin virtualización
**Solución:**

```dart
// GridView.builder ya es virtualizado, pero optimiza:
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.75,
    // Reduce mainAxisSpacing si es necesario
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    // Evita hacer cálculos complejos aquí
    return FoodCard(item: items[index]);
  },
);
```

#### Muchas peticiones a Supabase

**Causa:** Providers se actualizan frecuentemente
**Solución:**

```dart
// Usa select para evitar reconstrucciones:
ref.watch(foodItemsProvider.select((data) => data.length));
// Mejor que:
ref.watch(foodItemsProvider);
```

---

### 9. ❌ PROBLEMAS EN DEPLOYMENT

#### APK no inicia

**Causa:** Supabase no se inicializó
**Solución:**

```dart
// En main.dart:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(...); // ← IMPORTANTE
  runApp(...);
}
```

#### Credenciales en APK final

**Solución:**

```dart
// NUNCA commits credentials en git:
# .gitignore:
lib/config/supabase_config.dart

// En CI/CD, inyecta variables de entorno
```

---

### 10. ❌ ERRORES DE VALIDACIÓN

#### "Email inválido" en signup

**Solución:**

```dart
// Mejorar validación:
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email requerido';
  }
  final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!regex.hasMatch(value)) {
    return 'Email inválido';
  }
  return null;
}
```

#### Contraseña débil no detectada

**Solución:**

```dart
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Contraseña requerida';
  }
  if (value.length < 6) {
    return 'Mínimo 6 caracteres';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Debe incluir mayúscula (opcional)';
  }
  return null;
}
```

---

## 🆘 DEBUGGING

### Activar Logs de Supabase

```dart
Supabase.instance.client.auth.onAuthStateChange.listen((data) {
  print('Auth state: ${data.event}');
  print('User: ${data.session?.user.email}');
});
```

### Ver Peticiones HTTP

```dart
// Agregar en main.dart antes de initialize:
// Supabase usa dio, que muestra logs automáticamente
```

### Inspeccionar BD en Vivo

```
1. Supabase → Table Editor
2. Click en una tabla
3. Observa en tiempo real los cambios
```

### Ver Errores en Supabase

```
1. Supabase → Logs → Edge Functions
2. O → Database → Logs
3. Busca errors recientes
```

---

## 📞 RECURSOS DE AYUDA

1. **Documentación Oficial**

   - https://supabase.com/docs/guides/getting-started
   - https://pub.dev/packages/supabase_flutter

2. **Community**

   - Supabase Discord
   - Flutter Community Discord

3. **Generar Reporte de Error**
   ```bash
   flutter doctor -v
   flutter run -v  # Captura logs
   ```

---

## ✅ CHECKLIST DE DEBUG

Cuando algo no funcione, revisa en orden:

```
☑ ¿Supabase está iniciado? (WidgetsFlutterBinding.ensureInitialized())
☑ ¿Credenciales son correctas? (URL y Anon Key)
☑ ¿Tablas existen? (Table Editor en Supabase)
☑ ¿RLS está habilitado? (ALTER TABLE ... ENABLE ROW LEVEL SECURITY)
☑ ¿Usuario autenticado? (currentUserProvider)
☑ ¿Token válido? (No expirado)
☑ ¿Proveedores se cargan? (Usa .when() para ver estado)
☑ ¿Errores de red? (Verificar firewall/VPN)
☑ ¿Versiones compatibles? (flutter --version)
```

---

**¡Si aún así no funciona, contacta a soporte!** 🆘
