# Guía de Configuración - App Pedidos con Supabase

## 📋 Requisitos Previos

- Flutter 3.6.0+
- Dart 3.0.0+
- Cuenta en [Supabase](https://supabase.com)

---

## 🔧 PASO 1: Crear Proyecto en Supabase

1. Ve a https://app.supabase.com
2. Haz clic en "New Project"
3. Completa los datos:
   - **Project Name**: app-pedidos
   - **Database Password**: Crea una contraseña fuerte
   - **Region**: Elige la más cercana a tu ubicación
4. Espera a que se cree el proyecto (5-10 minutos)

---

## 🗄️ PASO 2: Configurar Base de Datos

1. En Supabase, ve a **SQL Editor**
2. Abre el archivo `SETUP_SUPABASE.sql` de este proyecto
3. Copia TODO el contenido del archivo SQL
4. En Supabase, pega el código SQL en el editor y ejecuta (botón de ejecutar)
5. Espera a que se creen todas las tablas

### Verificar que se crearon las tablas:

- Ve a **Table Editor** en Supabase
- Deberías ver: `users`, `food_items`, `orders`, `order_items`

---

## 🔑 PASO 3: Obtener Credenciales de Supabase

1. En tu proyecto Supabase, ve a **Settings** → **API**
2. Copia estos dos valores:
   - **Project URL** (en la sección "Project URL")
   - **Anon Key** (en la sección "Project API Keys")

---

## ⚙️ PASO 4: Configurar la App

1. Abre el archivo `lib/config/supabase_config.dart`
2. Reemplaza los valores:

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://YOUR_PROJECT_ID.supabase.co';
  static const String supabaseAnonKey = 'YOUR_ANON_KEY';
}
```

**Por ejemplo:**

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://abcdefghijk.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
}
```

---

## 📦 PASO 5: Instalar Dependencias

Ejecuta en la terminal:

```bash
flutter pub get
```

---

## 🚀 PASO 6: Ejecutar la App

```bash
flutter run
```

---

## 📧 CONFIGURACIÓN DEL EMAIL PARA RESETEAR CONTRASEÑA

Supabase enviará automáticamente emails de reseteo, pero necesitas configurar:

1. En Supabase, ve a **Authentication** → **Email Templates**
2. Personaliza el template de "Reset Password" si lo deseas
3. Por defecto, incluye un link que redirige a tu app

**En desarrollo**, Supabase enviará a un email de prueba. Para testing:

- Ve a **Authentication** → **Users**
- Busca el usuario
- Haz clic en el email para ver los detalles

---

## 🧪 PRUEBAS INICIALES

### 1. **Registro:**

- Abre la app
- Haz clic en "Regístrate"
- Ingresa un email y contraseña (mín. 6 caracteres)
- Haz clic en "Registrarse"

### 2. **Login:**

- Ingresa el email y contraseña que registraste
- Haz clic en "Iniciar Sesión"

### 3. **Ver Menú:**

- Deberías ver los items de comida cargados desde Supabase
- Si no aparecen, verifica las tablas en Supabase

### 4. **Crear Pedido:**

- Agrega items al carrito
- Completa los datos de entrega
- Haz clic en "Confirmar Pedido"
- Verifica que aparezca en la pantalla de Pedidos

### 5. **Recuperar Contraseña:**

- En el login, haz clic en "¿Olvidaste tu contraseña?"
- Ingresa tu email
- Deberías recibir un email (en desarrollo, verifica en Supabase)

---

## 🐛 SOLUCIÓN DE PROBLEMAS

### Error: "Connection refused"

**Solución:** Verifica que hayas copiado correctamente la URL de Supabase

### Error: "Invalid API key"

**Solución:** Asegúrate de usar la **Anon Key**, no la Service Role Key

### No aparecen los items de comida

**Solución:**

1. Verifica que ejecutaste el SQL en SETUP_SUPABASE.sql
2. Ve a Supabase → Table Editor → food_items
3. Deberías ver 8 items de ejemplo

### No puedo registrarme

**Solución:**

1. Verifica en Supabase → Authentication → Policies que RLS esté habilitado
2. Usa una contraseña de al menos 6 caracteres

---

## 🔐 SEGURIDAD - ROW LEVEL SECURITY (RLS)

La app tiene RLS habilitado para que:

- **Cada usuario solo vea sus propios pedidos**
- **Solo puede actualizar su propio perfil**
- **Todos pueden ver el menú de comida**

Si deseas cambiar estas políticas:

- Ve a Supabase → Tables → [Tabla] → RLS
- Edita las políticas según necesites

---

## 📱 DEPLOYMENT A PRODUCCIÓN

### Para Android/iOS:

```bash
flutter build apk        # Android
flutter build ios        # iOS
```

**Importante:**

- En producción, usa variables de entorno para las credenciales
- Nunca commits las credenciales en GitHub
- Usa el Service Role Key solo en backend seguro

### Para Web:

```bash
flutter build web
```

---

## 📚 RECURSOS ÚTILES

- [Documentación Supabase](https://supabase.com/docs)
- [Documentación Supabase Flutter](https://supabase.com/docs/reference/flutter/introduction)
- [Documentación Go Router](https://pub.dev/packages/go_router)
- [Documentación Riverpod](https://riverpod.dev)

---

## 💡 SIGUIENTES PASOS (Opcional)

- [ ] Agregar autenticación con Google/GitHub
- [ ] Implementar pagos (Stripe, PayPal)
- [ ] Agregar fotos a los items de comida
- [ ] Crear dashboard de admin
- [ ] Agregar notificaciones en tiempo real
- [ ] Implementar ratings/reviews

---

¡Listo! Tu app debería estar funcionando. 🎉
