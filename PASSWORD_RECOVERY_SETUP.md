# 🔐 RECUPERACIÓN DE CONTRASEÑA - GUÍA DE INTEGRACIÓN

## 📍 UBICACIÓN DE ARCHIVOS

```
app_pedidos/
└── web-recovery/                    ← NUEVA CARPETA
    ├── reset-password.html          ← Página de reset
    ├── styles.css                   ← Estilos profesionales
    ├── script.js                    ← Lógica Supabase
    ├── package.json                 ← Para desplegar
    ├── README.md                    ← Guía completa
    └── QUICKSTART.md                ← Setup en 5 minutos
```

---

## 🎯 ¿QUÉ ES?

Una **página HTML profesional** para recuperar contraseñas en Supabase:

```
Usuario olvida contraseña
        ↓
Usa "Forgot Password" en Flutter
        ↓
Supabase envía email con link
        ↓
Link abre reset-password.html
        ↓
Usuario ingresa nueva contraseña
        ↓
Se cambia automáticamente en Supabase
        ↓
Usuario puede iniciar sesión
```

---

## ⚡ INICIO RÁPIDO (5 MINUTOS)

### 1. Actualiza script.js

Abre `web-recovery/script.js` líneas 8-9:

```javascript
const SUPABASE_URL = "https://abc123.supabase.co"; // TU URL
const SUPABASE_ANON_KEY = "eyJhbGc..."; // TU CLAVE
```

### 2. Configura en Supabase

En Supabase → Authentication → URL Configuration:

```
http://localhost:8000/reset-password.html
```

### 3. Prueba localmente

```bash
cd web-recovery
python -m http.server 8000
# Abre: http://localhost:8000/reset-password.html
```

### 4. Despliega

```bash
# Opción A: Vercel (MÁS FÁCIL)
npm install -g vercel
vercel

# Opción B: Railway
npm install -g @railway/cli
railway login
railway init

# Opción C: Netlify
npm install -g netlify-cli
netlify deploy
```

### 5. Actualiza URL en Supabase

Después de desplegar:

```
https://tu-dominio.com/web-recovery/reset-password.html
```

---

## 📋 COMPONENTES

### `reset-password.html` - Estructura

```
✅ Header profesional con logo
✅ Estados visuales:
   - Cargando (validando token)
   - Formulario (ingresando contraseña)
   - Éxito (contraseña cambiada)
   - Error (link expirado)
   - Enviando (mientras se cambia)
✅ Validación de contraseña
✅ Toggle mostrar/ocultar contraseña
✅ Botón para solicitar nuevo link
✅ Footer profesional
✅ Responsive (funciona en móvil)
```

### `script.js` - Funcionalidad

```
✅ Lee Supabase URL y Anon Key
✅ Valida sesión del usuario
✅ Maneja cambio de contraseña
✅ Error handling completo
✅ Validación de contraseña
✅ Integración con API Supabase
✅ Soporte para deep linking
```

### `styles.css` - Diseño

```
✅ Diseño profesional
✅ Gradientes animados
✅ Animaciones suaves
✅ Tema oscuro (auto-detecta)
✅ Responsive (móvil, tablet, desktop)
✅ Validación visual
✅ Accesibilidad mejorada
```

---

## 🔐 SEGURIDAD

### ✅ Implementado

- ✅ Validación de token de Supabase
- ✅ HTTPS en producción
- ✅ Contraseña mínimo 6 caracteres
- ✅ Confirmación de contraseña
- ✅ Row Level Security (RLS) en BD
- ✅ Sin almacenamiento de contraseña
- ✅ Tokens con expiración

### ❌ Evita

- ❌ Dejar credenciales en código visible
- ❌ HTTP en producción (debe ser HTTPS)
- ❌ Desactivar RLS en Supabase
- ❌ Compartir script.js sin actualizar

---

## 📱 INTEGRACIÓN CON FLUTTER

### 1. ForgotPasswordScreen.dart (Ya existe)

```dart
// El usuario hace click en "Forgot Password"
// Ingresa su email
// Supabase envía email automáticamente
```

### 2. Email de Supabase

```
Asunto: Restablecer tu contraseña
Link: https://tu-dominio.com/web-recovery/reset-password.html?token=...
```

### 3. Usuario abre link

```
Se abre reset-password.html en navegador
↓
Script.js valida token
↓
Muestra formulario
↓
Usuario cambia contraseña
↓
Mensaje de éxito
```

---

## 🚀 DEPLOYMENT

### Vercel (Recomendado - MÁS FÁCIL)

```bash
npm install -g vercel
vercel

# Tu URL será: https://app-pedidos.vercel.app/web-recovery/
```

**Ventajas:**

- Gratis
- HTTPS automático
- Deploy desde Git
- Muy rápido

### Railway

```bash
npm install -g @railway/cli
railway login
railway init

# Tu URL será: https://app-pedidos.railway.app/web-recovery/
```

### Netlify

```bash
npm install -g netlify-cli
netlify deploy

# Tu URL será: https://app-pedidos.netlify.app/web-recovery/
```

---

## 📧 TESTING

### Test 1: Email se envía

```bash
# En Flutter, usa "Forgot Password"
# Revisa tu email (incluido spam)
```

### Test 2: Link funciona

```bash
# Abre el link del email
# Debería mostrar formulario (no error)
```

### Test 3: Cambio de contraseña

```bash
# Ingresa nueva contraseña
# Click en "Restablecer"
# Debería mostrar éxito
# En Supabase → Users, contraseña cambió
```

---

## ⚠️ TROUBLESHOOTING

| Error                        | Solución                                   |
| ---------------------------- | ------------------------------------------ |
| "SUPABASE_URL no encontrado" | Actualiza script.js con URL correcta       |
| "Redirect URL inválida"      | Agrega URL en Supabase → URL Configuration |
| "Link expirado"              | Los links duran 1 hora. Pide uno nuevo.    |
| "Contrasenas no coinciden"   | Verifica que sean exactamente iguales      |
| "No ve bien en móvil"        | CSS ya es responsive. Verifica zoom        |

---

## 📚 REFERENCIAS

- **Documentación oficial:** https://supabase.com/docs/guides/auth/passwords
- **Email Templates:** https://supabase.com/docs/guides/auth/customizing-mail-templates
- **URL Configuration:** https://supabase.com/docs/guides/auth/redirect-urls

---

## ✅ CHECKLIST ANTES DE PRODUCCIÓN

- [ ] Actualicé SUPABASE_URL en script.js
- [ ] Actualicé SUPABASE_ANON_KEY en script.js
- [ ] Configuré Redirect URL en Supabase
- [ ] Probé localmente
- [ ] Desplegué a Vercel/Railway/Netlify
- [ ] Actualicé URL en Supabase después de desplegar
- [ ] Probé flujo completo: Forgot → Email → Reset → Success
- [ ] Verificé que funciona en móvil
- [ ] Personalicé logo y colores (opcional)

---

## 📞 PRÓXIMOS PASOS

1. **Personalizar email** (opcional)

   - Supabase → Authentication → Email Templates

2. **Agregar Deep Linking** (opcional)

   - Que vuelva automáticamente a la app

3. **Monitorear errores** (recomendado)
   - Configura Sentry o similar

---

**¡Tu página de recuperación de contraseña está lista para producción!** 🎉

### 👉 Empieza aquí: [web-recovery/QUICKSTART.md](web-recovery/QUICKSTART.md)

### 📖 Más detalles: [web-recovery/README.md](web-recovery/README.md)
