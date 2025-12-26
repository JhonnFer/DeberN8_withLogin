# 🔐 GUÍA DE CONFIGURACIÓN CON .ENV

## 📋 ¿Qué es el archivo `.env`?

El archivo `.env` es un archivo de **configuración local** que contiene credenciales y variables sensibles:

```
.env = Archivo LOCAL (nunca se commitea a Git)
.env.example = Plantilla para compartir sin credenciales
```

**Ventajas:**

- ✅ Seguridad: Credenciales no en el código
- ✅ Fácil de cambiar: Sin recompilar
- ✅ Múltiples entornos: Dev, testing, producción
- ✅ Evita accidentes: `.gitignore` protege el archivo

---

## ⚙️ CONFIGURACIÓN INICIAL (5 minutos)

### Paso 1: Crear archivo `.env`

Ya está creado en la raíz del proyecto. Ábrelo en VS Code:

```
app_pedidos/
├── .env ← AQUÍ ESTÁN TUS CREDENCIALES
├── .env.example ← PLANTILLA SEGURA PARA GITHUB
└── ...
```

### Paso 2: Copiar plantilla

Abre `.env.example` y copia el contenido a `.env`:

```bash
# En PowerShell:
Copy-Item .env.example .env
```

O simplemente copia/pega manualmente en VS Code.

### Paso 3: Obtener credenciales de Supabase

1. Ve a https://app.supabase.com
2. Abre tu proyecto
3. Ve a **Settings → API**
4. Copia:
   - **Project URL** → pégalo en `SUPABASE_URL`
   - **anon (public) key** → pégalo en `SUPABASE_ANON_KEY`

### Paso 4: Llenar el `.env`

```env
# 🔐 CREDENCIALES SUPABASE
SUPABASE_URL=https://abcdefghijk.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# 🚂 CREDENCIALES RAILWAY (opcional)
RAILWAY_API_KEY=railway_...
RAILWAY_EMAIL_SERVICE_URL=https://your-app.railway.app

# 🔧 CONFIGURACIÓN
APP_ENV=development
DEBUG_MODE=true
```

### Paso 5: Verificar que funciona

```bash
flutter pub get
flutter run
```

Si ves errores sobre `.env` no encontrado, asegúrate de que:

- ✅ El archivo `.env` está en la raíz del proyecto
- ✅ Las credenciales están correctas
- ✅ Los nombres de variables coinciden exactamente

---

## 📁 ESTRUCTURA DE ARCHIVOS

```
app_pedidos/
│
├── 📄 .env ← TU ARCHIVO LOCAL (GITIGNORED)
│   ├── SUPABASE_URL = credencial real
│   └── SUPABASE_ANON_KEY = credencial real
│
├── 📄 .env.example ← PLANTILLA PÚBLICA
│   ├── SUPABASE_URL = https://YOUR_PROJECT_ID.supabase.co
│   └── SUPABASE_ANON_KEY = YOUR_ANON_KEY
│
├── 📄 .gitignore
│   └── .env ← NUNCA se commitea
│
├── pubspec.yaml
│   └── flutter_dotenv: ^5.1.0 ← NUEVA DEPENDENCIA
│
└── lib/
    ├── main.dart ✏️ ACTUALIZADO
    │   └── await dotenv.load(fileName: '.env');
    │
    └── config/
        └── supabase_config.dart ✏️ ACTUALIZADO
            ├── dotenv.env['SUPABASE_URL']
            └── dotenv.env['SUPABASE_ANON_KEY']
```

---

## 🔐 VARIABLES DISPONIBLES

### Supabase

```dart
SupabaseConfig.supabaseUrl          // URL del proyecto
SupabaseConfig.supabaseAnonKey      // Clave pública
```

### Railway (Opcional)

```dart
SupabaseConfig.railwayApiKey        // API Key de Railway
SupabaseConfig.railwayEmailServiceUrl // URL del servicio
```

### Configuración

```dart
SupabaseConfig.appEnv              // "development" o "production"
SupabaseConfig.debugMode           // true o false
```

---

## 🛡️ SEGURIDAD - QUÉ NO HACER

### ❌ MAL

```dart
// NUNCA hardcodees credenciales:
const String url = 'https://abc.supabase.co';
const String key = 'eyJhbGciOi...';
```

### ❌ MAL

```bash
# NUNCA commitees el .env:
git add .env
git commit -m "Add credentials"
```

### ❌ MAL

```env
# NO compartas credenciales en Slack, email, etc:
SUPABASE_ANON_KEY=eyJhbGciOi...
```

### ✅ BIEN

```
✅ Usar variables de entorno (.env)
✅ Agregar .env a .gitignore
✅ Compartir solo .env.example
✅ Cada dev tiene su propio .env local
✅ Production usa secrets management (CI/CD)
```

---

## 🔄 VARIABLES POR ENTORNO

### Development (.env)

```env
SUPABASE_URL=https://dev-project.supabase.co
SUPABASE_ANON_KEY=dev_key_...
APP_ENV=development
DEBUG_MODE=true
```

### Production (CI/CD)

```env
SUPABASE_URL=https://prod-project.supabase.co
SUPABASE_ANON_KEY=prod_key_...
APP_ENV=production
DEBUG_MODE=false
```

---

## ⚠️ SI ALGO FALLA

### "Error: .env file not found"

```
✅ Solución: Asegúrate de que .env está en la raíz del proyecto
✅ Solución: Ejecuta: flutter clean && flutter pub get
```

### "Error: SUPABASE_URL not configured"

```
✅ Solución: El .env está vacío o sin la variable
✅ Solución: Verifica que la variable se llama exactamente "SUPABASE_URL"
```

### "Credenciales incorrectas"

```
✅ Solución: Copia nuevamente desde Settings → API en Supabase
✅ Solución: Asegúrate de copiar la "anon (public) key", no la service key
```

### ".env cambió pero la app sigue igual"

```
✅ Solución: Ejecuta: flutter clean
✅ Solución: Ejecuta: flutter pub get
✅ Solución: Ejecuta: flutter run
```

---

## 📊 COMPARACIÓN: ANTES vs DESPUÉS

### ANTES (Hardcodeado)

```dart
// ❌ Inseguro
class SupabaseConfig {
  static const String supabaseUrl = 'https://actual-url.supabase.co';
  static const String supabaseAnonKey = 'actual-key-123456789';
}
```

**Problemas:**

- ❌ Credenciales visibles en código
- ❌ No se puede cambiar sin recompilar
- ❌ Fácil de commitear por accidente
- ❌ Mismo valor para todos (dev, test, prod)

### DESPUÉS (Con .env)

```dart
// ✅ Seguro
class SupabaseConfig {
  static String get supabaseUrl {
    return dotenv.env['SUPABASE_URL'] ?? '';
  }

  static String get supabaseAnonKey {
    return dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  }
}
```

**Ventajas:**

- ✅ Credenciales en archivo local (.gitignored)
- ✅ Se puede cambiar sin recompilar
- ✅ Imposible commitear por accidente
- ✅ Valores diferentes por entorno

---

## 🚀 PASOS FINALES

### 1️⃣ Actualizar .env con tus credenciales

```env
SUPABASE_URL=https://TU_URL.supabase.co
SUPABASE_ANON_KEY=TU_CLAVE_AQUI
```

### 2️⃣ Instalar dependencia (ya está en pubspec.yaml)

```bash
flutter pub get
```

### 3️⃣ Ejecutar la app

```bash
flutter run
```

### 4️⃣ Verificar en .gitignore

```bash
# En PowerShell, abre .gitignore y verifica:
# .env ← debe estar aquí
```

### 5️⃣ Nunca commitear .env

```bash
# Verifica que Git ignora .env:
git status
# NO debe aparecer .env en "Changes to be committed"
```

---

## 💡 TIPS PROFESIONALES

### Tip 1: Validar .env al iniciar

```dart
// En main.dart, después de cargar .env:
if (SupabaseConfig.supabaseUrl.contains('YOUR_PROJECT_ID')) {
  throw Exception('⚠️ Llena .env con tus credenciales reales!');
}
```

### Tip 2: Múltiples entornos

```bash
# Crear archivos para cada entorno:
.env.development
.env.staging
.env.production

# Luego cargar dinámicamente:
await dotenv.load(fileName: '.env.${env}');
```

### Tip 3: Compartir proyecto sin comprometer seguridad

```bash
# Con Git:
git commit .env.example    ✅ OK - compartir
git commit .env            ❌ NUNCA - gitignored automáticamente

# El colega hace:
cp .env.example .env
# Llena sus propias credenciales
```

---

## 📞 RESUMEN RÁPIDO

| Acción              | Archivo         | Git             |
| ------------------- | --------------- | --------------- |
| 🔐 Tus credenciales | `.env`          | ❌ NO commitear |
| 📋 Plantilla        | `.env.example`  | ✅ Sí commitear |
| 🚫 Reglas           | `.gitignore`    | ✅ Sí commitear |
| 📦 Dependencia      | `pubspec.yaml`  | ✅ Sí commitear |
| 🔧 Cargar .env      | `lib/main.dart` | ✅ Sí commitear |

---

## ✅ CHECKLIST FINAL

- [ ] Archivo `.env` existe en raíz
- [ ] `.env` contiene `SUPABASE_URL` (no `YOUR_PROJECT_ID`)
- [ ] `.env` contiene `SUPABASE_ANON_KEY` (no `YOUR_ANON_KEY`)
- [ ] `.env` está en `.gitignore`
- [ ] `pubspec.yaml` tiene `flutter_dotenv: ^5.1.0`
- [ ] `lib/main.dart` importa `flutter_dotenv`
- [ ] `lib/main.dart` carga `.env` con `dotenv.load()`
- [ ] `supabase_config.dart` usa `dotenv.env['...']`
- [ ] `flutter pub get` ejecuta sin errores
- [ ] `flutter run` inicia sin errores de credenciales

---

**¡Ahora tu app es segura y profesional!** 🎉
