# ⚡ SETUP RÁPIDO - RECUPERACIÓN DE CONTRASEÑA

## 5 MINUTOS PARA QUE FUNCIONE

### Paso 1: Actualizar Credenciales (1 min)

Abre `web-recovery/script.js` y reemplaza (líneas 8-9):

```javascript
// ANTES (❌ Falso)
const SUPABASE_URL = "https://YOUR_PROJECT_ID.supabase.co";
const SUPABASE_ANON_KEY = "YOUR_ANON_KEY";

// DESPUÉS (✅ Tu URL real)
const SUPABASE_URL = "https://abc123.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...";
```

**¿De dónde copiar?**

- Ve a https://app.supabase.com → Tu proyecto → Settings → API
- Copia "Project URL" y "anon (public) key"

### Paso 2: Configurar en Supabase (2 min)

1. En Supabase → **Authentication → URL Configuration**
2. En **Redirect URLs**, agrega:

   ```
   http://localhost:8000/reset-password.html
   ```

   (Para testing local. Cambiarás cuando despliegues a producción)

3. Click en **Save**

### Paso 3: Probar Localmente (1 min)

```bash
cd web-recovery
python -m http.server 8000

# Abre en navegador:
http://localhost:8000/reset-password.html
```

**Debería ver:** Una página con formulario de contraseña

### Paso 4: Desplegar a Producción (1 min)

**Opción A: Vercel (Más fácil)**

```bash
npm install -g vercel
vercel
```

**Opción B: Railway**

```bash
npm install -g @railway/cli
railway login
railway init
railway up
```

**Opción C: Netlify**

```bash
npm install -g netlify-cli
netlify deploy
```

### Paso 5: Actualizar URL en Supabase (30 seg)

Después de desplegar, en Supabase → URL Configuration:

```
https://tu-dominio.com/web-recovery/reset-password.html
```

---

## ✅ VERIFICAR QUE FUNCIONA

```bash
# 1. Abre la app Flutter
flutter run

# 2. Ve a "Forgot Password"
# 3. Ingresa un email de test

# 4. Verifica el email (revisa spam también)

# 5. Abre el link del email

# 6. Debería mostrar formulario

# 7. Ingresa nueva contraseña

# 8. Click en "Restablecer"

# 9. Debería mostrar "✅ ¡Contraseña restablecida!"
```

---

## 🚀 PRÓXIMOS PASOS

1. **Configurar Deep Linking** (opcional)

   - Vuelve automáticamente a la app después de reset

2. **Agregar Branding**

   - Cambia el emoji 🍔 por tu logo
   - Ajusta los colores en `styles.css`

3. **Personalizar Email**
   - En Supabase → Authentication → Email Templates
   - Personaliza el email de reset

---

## ⚠️ SI ALGO NO FUNCIONA

| Problema                      | Solución                                          |
| ----------------------------- | ------------------------------------------------- |
| "SUPABASE_URL no configurado" | Copia exactamente desde Supabase → Settings → API |
| "Redirect URL no válida"      | Verifica que esté en Supabase → URL Configuration |
| "Link expirado"               | Los links duran 1 hora. Pide uno nuevo.           |
| "No veo el formulario"        | Abre DevTools (F12) y verifica console            |

---

## 📁 ARCHIVOS PRINCIPALES

```
web-recovery/
├── reset-password.html   ← Todo comienza aquí
├── script.js             ← Reemplaza SUPABASE_URL y KEY
├── styles.css            ← Estilos (no necesitas cambiar)
├── package.json          ← Para desplegar
└── README.md             ← Guía completa
```

---

**¡Listo! Tu página de recuperación de contraseña está funcionando.** 🎉

Para más detalles, lee [README.md](README.md)
