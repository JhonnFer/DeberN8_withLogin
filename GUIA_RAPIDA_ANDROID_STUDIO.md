# 🚀 GUÍA RÁPIDA - EJECUTAR EN ANDROID STUDIO

## ✅ ESTADO: APP FUNCIONAL - LOGIN OPERACIONAL

Tu app está lista para ejecutarse. Solo necesitas:

---

## 🔧 PASO 1: Configurar Supabase (2 minutos)

### 1.1 Crear Proyecto en Supabase

```
1. Ve a https://app.supabase.com
2. Click "New Project"
3. Ingresa:
   - Name: "app-pedidos"
   - Password: (contraseña fuerte)
4. Selecciona región: (cualquiera)
5. Click "Create new project" (espera 5-10 minutos)
```

### 1.2 Crear Tablas en Supabase

```
1. En Supabase, ve a: SQL Editor (en el menú izquierdo)
2. Click en "New Query"
3. Abre el archivo: SETUP_SUPABASE.sql (en tu proyecto)
4. Copia TODO el contenido
5. Pégalo en el editor SQL de Supabase
6. Click en "Run" (botón verde)
7. Espera a que se completen todas las operaciones
```

### 1.3 Obtener Credenciales

```
1. En Supabase: Settings → API (esquina inferior izquierda)
2. Copia:
   - Project URL: (ej: https://abc123xyz.supabase.co)
   - Anon Key: (ej: eyJhbGc...)
```

---

## 📝 PASO 2: Configurar el .env (1 minuto)

**Archivo: `.env` (raíz del proyecto)**

```dotenv
SUPABASE_URL=https://TU_PROJECT_ID.supabase.co
SUPABASE_ANON_KEY=TU_ANON_KEY_AQUI

APP_ENV=development
DEBUG_MODE=true
```

**Reemplaza:**

- `TU_PROJECT_ID` → Tu ID de proyecto Supabase
- `TU_ANON_KEY_AQUI` → Tu Anon Key de Supabase

---

## 🎮 PASO 3: Ejecutar en Android Studio (1 minuto)

### 3.1 Abrir el Proyecto

```
1. Abre Android Studio
2. File → Open
3. Selecciona la carpeta: app_pedidos
4. Click "Open"
5. Espera a que cargue el proyecto (2-3 minutos)
```

### 3.2 Descargar Dependencias

```
1. En la terminal de Android Studio, ejecuta:
   flutter pub get

2. Espera a que termine (puede tomar 1-2 minutos)
```

### 3.3 Crear/Conectar Dispositivo

**Opción A: Emulador Android**

```
1. Tools → Device Manager (en Android Studio)
2. Click "+ Create Device"
3. Selecciona un dispositivo (ej: Pixel 5)
4. Click "Next" → "Finish"
5. Espera a que se descargue la imagen del sistema
6. Una vez creado, click en ▶ para iniciar
```

**Opción B: Dispositivo Real**

```
1. Conecta tu teléfono Android por USB
2. Habilita "Modo de desarrollador":
   - Ajustes → Acerca de → Toca 7 veces "Número de compilación"
3. Habilita "Depuración USB"
4. Acepta la conexión en el diálogo del teléfono
```

### 3.4 Ejecutar la App

```
1. En Android Studio, abre la terminal (Tab "Terminal" abajo)
2. Ejecuta:
   flutter run

3. Selecciona el dispositivo que deseas usar
4. Espera a que compile y se inicie la app (~2 minutos)
```

---

## 🧪 PASO 4: Probar el Login (1 minuto)

Una vez que la app está abierta:

### 4.1 Crear una Cuenta

```
1. Click en "¿No tienes cuenta? Regístrate"
2. Ingresa:
   - Email: tumail@example.com
   - Contraseña: Test123456
   - Confirmar: Test123456
3. Click "Registrarse"
4. Espera el mensaje de éxito
```

### 4.2 Iniciar Sesión

```
1. Ingresa:
   - Email: tumail@example.com
   - Contraseña: Test123456
2. Click "Iniciar Sesión"
3. Si todo está bien, verás la pantalla de Inicio (Home)
```

### 4.3 Cerrar Sesión

```
1. Click en el icono de menú (≡) arriba a la izquierda
2. Click en "Cerrar Sesión"
3. Volverás a la pantalla de login
```

---

## 🐛 SOLUCIONAR PROBLEMAS

### Error: "SUPABASE_URL no está configurado"

```
✓ Verifica que el archivo .env existe en la raíz del proyecto
✓ Verifica que tiene los valores correctos
✓ Ejecuta: flutter clean && flutter pub get
```

### Error: "No se puede conectar a Supabase"

```
✓ Verifica tu conexión a internet
✓ Verifica que SUPABASE_URL sea correcto
✓ Verifica que SUPABASE_ANON_KEY sea correcto
✓ Revisa la consola de Android Studio para más detalles
```

### La app no inicia en el emulador

```
✓ Detén la app actual: q (en la terminal)
✓ Ejecuta: flutter clean
✓ Ejecuta: flutter pub get
✓ Ejecuta: flutter run
```

### El login no funciona

```
✓ Verifica que creaste las tablas en Supabase (SETUP_SUPABASE.sql)
✓ Verifica que las credenciales en .env son correctas
✓ Revisa los logs en Android Studio (abajo, panel "Run")
```

---

## 📋 CHECKLIST

- [ ] Proyecto Supabase creado
- [ ] Tablas creadas (SETUP_SUPABASE.sql ejecutado)
- [ ] Credenciales obtenidas (URL y Anon Key)
- [ ] Archivo .env configurado correctamente
- [ ] `flutter pub get` ejecutado
- [ ] Dispositivo emulador/real conectado
- [ ] App ejecutándose con `flutter run`
- [ ] Login funcionando correctamente

---

## ✅ TODO LISTO

Una vez completados todos los pasos:

- ✓ App abierta en Android Studio
- ✓ Login funcionando
- ✓ Puedes crear cuentas y iniciar sesión
- ✓ Puedes cerrar sesión desde el menú lateral

**¡Listo! El login está 100% funcional.**

Si hay algún problema, revisa los logs en la consola de Android Studio para más detalles.
