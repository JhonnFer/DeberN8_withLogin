# ⚡ QUICK START - 5 Minutos

## 🎯 Tu app ya está lista, solo necesitas hacer esto:

### PASO 1️⃣: Ir a Supabase (2 min)

```
1. Abre https://app.supabase.com
2. Click "New Project"
3. Ingresa nombre: "app-pedidos"
4. Contraseña fuerte
5. Espera que se cree (5-10 min en background)
```

**Mientras espera, continúa con PASO 2...**

### PASO 2️⃣: Crear Base de Datos (2 min)

```
1. En Supabase → SQL Editor
2. Abre el archivo SETUP_SUPABASE.sql (en tu proyecto)
3. Copia TODO el contenido
4. En Supabase, pega en el editor
5. Click en "Run" (botón verde)
6. Espera a que se creen las tablas ✅
```

### PASO 3️⃣: Obtener Credenciales (1 min)

```
En Supabase:
1. Settings → API
2. Copia "Project URL" (ej: https://abc123.supabase.co)
3. Copia "Anon Key" (la larga con "eyJh...")
```

### PASO 4️⃣: Configurar la App (1 min)

**En tu editor:**

```
Abre: lib/config/supabase_config.dart

Reemplaza:
  supabaseUrl → tu URL de Supabase
  supabaseAnonKey → tu Anon Key
```

### PASO 5️⃣: Ejecutar (1 min)

```bash
flutter pub get
flutter run
```

---

## ✅ ¡LISTO!

La app debería abrir con:

- ✅ Pantalla de Login
- ✅ Opción de Registrarse
- ✅ Opción de Recuperar Contraseña

---

## 🧪 PRUEBA LA APP

```
1. Haz clic en "Regístrate"
2. Ingresa un email: tumail@example.com
3. Contraseña: minimo6caracteres
4. Haz clic en "Registrarse"
5. Deberías ver el Menú de Comida
6. Agrega items al carrito
7. Crea un pedido
8. Mira tus pedidos en "Mis Pedidos"
```

---

## 🤔 ¿Algo no funciona?

### ❌ "Connection refused"

```
→ Verifica que copiaste BIEN la URL de Supabase
  (sin espacios, con https:// al inicio)
```

### ❌ "Invalid API key"

```
→ Asegúrate de copiar la "Anon Key", no otra cosa
```

### ❌ "No aparecen items de comida"

```
→ En Supabase, ve a Table Editor
→ Verifica que exista la tabla "food_items"
→ Debería tener 8 items de ejemplo
```

### ❌ "No puedo registrarme"

```
→ La contraseña debe tener mínimo 6 caracteres
→ El email debe ser válido (con @)
```

---

## 📊 Ver Datos en Supabase

Para verificar que todo funciona:

```
1. En Supabase, ve a "Table Editor"
2. Expande tablas:
   ✅ food_items - Deberías ver 8 items
   ✅ users - Aparecerá cuando te registres
   ✅ orders - Aparecerá cuando crees un pedido
   ✅ order_items - Items de tus pedidos
```

---

## 🎉 ÉXITO!

Si ves esto:

```
┌─────────────────────────────┐
│    🍔 App Pedidos 🍔       │
├─────────────────────────────┤
│                             │
│  Hamburgesa 1     $3.50     │
│  Hamburguesa 2    $4.50     │
│  Pizza Margherita $8.00     │
│  ...                        │
│                             │
│        ✅ TODO FUNCIONA      │
│                             │
└─────────────────────────────┘
```

---

## 📚 Documentación Completa

Si necesitas más detalles:

- `GUIA_SETUP.md` - Setup detallado
- `README_INTEGRACION.md` - Documentación técnica
- `RESUMEN_CAMBIOS.md` - Cambios realizados
- `RAILWAY_VERCEL_SETUP.md` - Backend alternativo

---

## 💡 NEXT STEPS (Opcional)

Después que funcione:

- [ ] Agregar fotos a los items
- [ ] Integrar pagos (Stripe)
- [ ] Notificaciones push
- [ ] Dashboard admin
- [ ] Compartir en App Store/Play Store

---

**¡A codificar!** 🚀
