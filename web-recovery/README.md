# 🔐 RECUPERACIÓN DE CONTRASEÑA CON SUPABASE

## 📁 ¿QUÉ HAY EN ESTA CARPETA?

```
web-recovery/
├── reset-password.html   ← Página de recuperación (lo que ve el usuario)
├── styles.css            ← Estilos profesionales
├── script.js             ← Lógica de Supabase
├── package.json          ← Para servir localmente
└── README.md             ← Esta guía
```

---

## 🎯 CÓMO FUNCIONA

### Flujo Completo:

```
1. Usuario hace click en "Forgot Password" en app
   ↓
2. Ingresa su email
   ↓
3. Supabase envía email con link especial
   ↓
4. Usuario abre link en navegador (abre reset-password.html)
   ↓
5. Página valida token de Supabase
   ↓
6. Muestra formulario para nueva contraseña
   ↓
7. Usuario ingresa nueva contraseña
   ↓
8. Script.js usa Supabase API para cambiarla
   ↓
9. ¡Éxito! Usuario puede volver a la app
```

---

## ⚙️ CONFIGURACIÓN EN SUPABASE

### Paso 1: Obtener URL y Key

1. Ve a https://app.supabase.com
2. Abre tu proyecto
3. Ve a **Settings → API**
4. Copia:
   - **Project URL** (ejemplo: `https://abc123.supabase.co`)
   - **anon (public) key** (la larga con `eyJh...`)

### Paso 2: Actualizar script.js

En `web-recovery/script.js`, líneas 8-9:

```javascript
const SUPABASE_URL = "https://abc123.supabase.co"; // Reemplaza
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1Ni..."; // Reemplaza
```

### Paso 3: Configurar Redirect URL en Supabase

1. En Supabase, ve a **Authentication → URL Configuration**
2. En **Redirect URLs**, agrega:

   ```
   https://tu-dominio.com/web-recovery/reset-password.html
   ```

   **Ejemplos reales:**

   - `https://app-pedidos.vercel.app/web-recovery/reset-password.html`
   - `https://app-pedidos.railway.app/web-recovery/reset-password.html`
   - `http://localhost:8000/reset-password.html` (para testing local)

3. Click en **"Save"**

### Paso 4: Configurar Email Templates (Opcional pero recomendado)

En Supabase → **Authentication → Email Templates**:

1. Abre **Reset Password**
2. Edita el email para que el link apunte a tu URL:

   ```html
   <p>
     <a
       href="{{ .SiteURL }}/web-recovery/reset-password.html?token={{ .Token }}&type=recovery"
     >
       Restablecer Contraseña
     </a>
   </p>
   ```

---

## 🚀 DESPLEGAR A PRODUCCIÓN

### Opción A: VERCEL (Recomendado - MÁS FÁCIL)

```bash
# 1. Instala Vercel CLI
npm install -g vercel

# 2. Desde la raíz del proyecto
cd app_pedidos
vercel

# 3. Sigue el asistente, luego tu URL será:
# https://app-pedidos.vercel.app/web-recovery/reset-password.html
```

**Ventajas:**

- ✅ Gratis con 100 GB/mes
- ✅ Deploy automático con Git
- ✅ HTTPS automático
- ✅ Muy rápido

### Opción B: RAILWAY

```bash
# 1. Instala Railway CLI
npm install -g @railway/cli

# 2. Login
railway login

# 3. Desde la raíz del proyecto
cd app_pedidos
railway init

# 4. Tu URL será:
# https://your-project.railway.app/web-recovery/reset-password.html
```

### Opción C: NETLIFY

```bash
# 1. Instala Netlify CLI
npm install -g netlify-cli

# 2. Desde la raíz del proyecto
cd app_pedidos
netlify deploy

# 3. Tu URL será:
# https://your-site.netlify.app/web-recovery/reset-password.html
```

### Opción D: GITHUB PAGES (Gratis)

```bash
# 1. Crea una rama 'gh-pages'
git checkout -b gh-pages

# 2. Copia archivos a web-recovery/
# 3. Commit y push
git add .
git commit -m "Add password recovery"
git push origin gh-pages

# 4. Tu URL será:
# https://tu-usuario.github.io/app_pedidos/web-recovery/reset-password.html
```

---

## 🧪 TESTING LOCAL

### Opción 1: Python (Sin instalar nada)

```bash
cd web-recovery
python -m http.server 8000

# Abre: http://localhost:8000/reset-password.html
```

### Opción 2: Node.js

```bash
cd web-recovery
npx http-server -p 8080

# Abre: http://localhost:8080/reset-password.html
```

### Opción 3: PHP

```bash
cd web-recovery
php -S localhost:8000

# Abre: http://localhost:8000/reset-password.html
```

---

## 📋 ACTUALIZAR LA CARPETA SUPABASE_CONFIG

En `lib/config/supabase_config.dart`, ya está listo:

```dart
// Lee las credenciales del .env
static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
```

No necesitas cambiar nada más. ✅

---

## 🔄 FLUJO FLUTTER → WEB

### 1. Flutter (ForgotPasswordScreen.dart)

```dart
// Usuario hace click en "Forgot Password"
await SupabaseService.to.resetPassword(email);
// Supabase envía email con link
```

### 2. Email de Supabase

```
Asunto: Restablecer tu contraseña
Link: https://tu-dominio.com/web-recovery/reset-password.html?token=...
```

### 3. Usuario hace click en link

```
↓
Se abre reset-password.html en navegador
↓
Script.js valida el token
↓
Se muestra formulario
↓
Usuario ingresa nueva contraseña
↓
Se cambia en Supabase
↓
Mensaje de éxito
```

### 4. Volver a la app

```
Usuario ve botón "Ir a la App"
↓
Si tienes deep linking configurado, se abre la app automáticamente
↓
Si no, muestra un mensaje diciendo que abra la app
```

---

## 🔗 DEEP LINKING (Opcional)

Para que el usuario vuelva automáticamente a la app después de reset:

### En Flutter (lib/main.dart)

```dart
// Ya está configurado con Go Router
// La app redirige automáticamente a /login después de reset
```

### En HTML (web-recovery/script.js)

```javascript
function openApp() {
  // Opción 1: Deep link
  window.location.href = "app-pedidos://login";

  // Opción 2: URL web
  // window.location.href = 'https://app-pedidos.web.app';

  // Opción 3: Solo mensaje
  // alert('Abre la app...');
}
```

---

## ⚠️ VARIABLES DE ENTORNO

### Actualizar en script.js

Si usas el archivo `.env` de la app, necesitas hacer esto diferente en la web.

**Mejor práctica:** Crear `.env.web`:

```bash
# .env.web (en raíz del proyecto)
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=tu-clave-aqui
```

Luego, en CI/CD (GitHub Actions, Vercel, Railway), inyectar variables:

```yaml
# .github/workflows/deploy.yml
env:
  SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
  SUPABASE_ANON_KEY: ${{ secrets.SUPABASE_ANON_KEY }}
```

---

## 🛡️ SEGURIDAD

### ✅ BIEN

- ✅ Credenciales en variables de entorno
- ✅ HTTPS obligatorio en producción
- ✅ RLS habilitado en Supabase
- ✅ Validación en client y server
- ✅ Tokens con expiración

### ❌ MAL

- ❌ Credenciales en el código visible
- ❌ HTTP en producción
- ❌ RLS deshabilitado
- ❌ Confiar solo en validación del cliente

---

## 📧 TESTING DE EMAIL

### Test 1: Verificar que el email se envía

```bash
# En Supabase → Auth → Logs
# Debería haber un email "Reset Password" enviado
```

### Test 2: Verificar el link

```
1. Copia el link del email de test
2. Abre en navegador
3. Debería mostrar el formulario
```

### Test 3: Cambiar contraseña

```
1. Ingresa nueva contraseña
2. Confirma
3. Click en "Restablecer"
4. Debería mostrar mensaje de éxito
5. En Supabase → Auth → Users, la contraseña cambió
```

---

## 🐛 TROUBLESHOOTING

### Error: "SUPABASE_URL no encontrado"

**Solución:**

- Verifica que script.js tenga la URL correcta
- Asegúrate de que SUPABASE_URL no contiene espacios

### Error: "Credenciales inválidas"

**Solución:**

- Copia nuevamente desde Settings → API
- Verifica que estés usando la "anon (public) key", NO la service key

### Error: "Redirect URL no configurada"

**Solución:**

1. En Supabase → Authentication → URL Configuration
2. Agrega la URL exacta donde está hospedada la página
3. Click en Save

### Error: "Link expirado"

**Solución:**

- Los links expiran en 1 hora (configurable en Supabase)
- Usuario puede pedir uno nuevo desde el botón "Solicitar nuevo enlace"

### No se ve bien en móvil

**Verificar:**

- Abre DevTools (F12)
- Toggle device mode (Ctrl+Shift+M)
- Verifica que sea responsive
- Si no, edita CSS (está preparado para mobile)

---

## 📊 ESTRUCTURA DE ARCHIVOS FINAL

```
app_pedidos/
├── web-recovery/
│   ├── reset-password.html   ← Página principal
│   ├── styles.css            ← Estilos (mobile-ready)
│   ├── script.js             ← Lógica Supabase
│   ├── package.json          ← Para desplegar
│   └── README.md             ← Esta guía
│
├── lib/
│   ├── main.dart             ← App Flutter
│   ├── config/supabase_config.dart
│   ├── funciones/auth/       ← Pantallas auth
│   └── ...
│
├── .env                      ← Credenciales locales
├── pubspec.yaml              ← Dependencias
└── README.md                 ← Guía principal
```

---

## ✅ CHECKLIST FINAL

- [ ] Actualicé SUPABASE_URL en script.js
- [ ] Actualicé SUPABASE_ANON_KEY en script.js
- [ ] Configuré Redirect URL en Supabase
- [ ] Probé localmente (python -m http.server 8000)
- [ ] Desplegué a Vercel/Railway/Netlify
- [ ] Actualicé la URL en Supabase → URL Configuration
- [ ] Pruebé el flujo completo: Forgot → Email → Reset → Success
- [ ] Verifiqué que funciona en móvil
- [ ] Configuré deep linking (opcional)

---

## 🚀 RESUMEN RÁPIDO

### Para usuarios finales:

```
1. Abre la app
2. Click en "¿Olvidaste tu contraseña?"
3. Ingresa tu email
4. Recibe email con link
5. Abre link
6. Ingresa nueva contraseña
7. ¡Listo! Inicia sesión con nueva contraseña
```

### Para desarrolladores:

```
1. Actualiza SUPABASE_URL y SUPABASE_ANON_KEY en script.js
2. Configura Redirect URL en Supabase
3. Despliega web-recovery/ a Vercel/Railway
4. Prueba el flujo completo
5. ¡Listo!
```

---

## 📞 SOPORTE

- **Documentación oficial:** https://supabase.com/docs/guides/auth
- **Ejemplos:** https://github.com/supabase/auth-helpers
- **Forum:** https://github.com/supabase/supabase/discussions

---

**¡Tu página de recuperación de contraseña está lista!** 🎉
