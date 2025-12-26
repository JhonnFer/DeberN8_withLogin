// ========================================
// CONFIGURACIÓN SUPABASE
// ========================================

// IMPORTANTE: Actualiza estos valores con los de tu proyecto Supabase
// Obtén estos valores de: https://app.supabase.com → Settings → API

// 🔐 OPCIÓN 1: Usar variables de entorno (RECOMENDADO PARA RAILWAY)
// En Railway: railway link → Variables → Agregar:
//   SUPABASE_URL=https://tu-proyecto.supabase.co
//   SUPABASE_ANON_KEY=eyJhbGc...
const SUPABASE_URL = "https://prnijxtfspduxanobawa.supabase.co";
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBybmlqeHRmc3BkdXhhbm9iYXdhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY3MjIwNTIsImV4cCI6MjA4MjI5ODA1Mn0.kIvzqYTeEOieb8ARM24u8mWoJirr0kXvnvDiQR8pzk4";

// 📍 URL donde se hospeda este archivo (usada para redirect después de reset)
// Ejemplos:
//   - Local: http://localhost:3000/
//   - Railway: https://tu-app-pwd-recovery.up.railway.app/
//   - Vercel: https://app-pedidos.vercel.app/web-recovery/
const REDIRECT_BASE_URL =
  window.location.origin +
  window.location.pathname.split("reset-password.html")[0];

console.log("🔐 REDIRECT_BASE_URL:", REDIRECT_BASE_URL);

// Inicializar cliente Supabase
const { createClient } = window.supabase;
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// ========================================
// ELEMENTOS DEL DOM
// ========================================

const loadingState = document.getElementById("loading");
const formState = document.getElementById("resetForm");
const successState = document.getElementById("success");
const errorState = document.getElementById("error");
const sendingState = document.getElementById("sending");

const passwordInput = document.getElementById("password");
const passwordConfirmInput = document.getElementById("passwordConfirm");
const passwordError = document.getElementById("passwordError");
const errorMessage = document.getElementById("errorMessage");

// ========================================
// FUNCIONES DE UI
// ========================================

function showState(state) {
  loadingState.classList.add("hidden");
  formState.classList.add("hidden");
  successState.classList.add("hidden");
  errorState.classList.add("hidden");
  sendingState.classList.add("hidden");

  state.classList.remove("hidden");
}

function togglePassword() {
  const input = document.getElementById("password");
  input.type = input.type === "password" ? "text" : "password";
}

function togglePasswordConfirm() {
  const input = document.getElementById("passwordConfirm");
  input.type = input.type === "password" ? "text" : "password";
}

function showPasswordError(message) {
  passwordError.textContent = message;
  passwordError.classList.remove("hidden");
}

function hidePasswordError() {
  passwordError.classList.add("hidden");
}

// ========================================
// MANEJO DEL FORMULARIO
// ========================================

document.getElementById("resetForm").addEventListener("submit", async (e) => {
  e.preventDefault();

  const password = passwordInput.value.trim();
  const passwordConfirm = passwordConfirmInput.value.trim();

  // Validación
  if (password.length < 6) {
    showPasswordError("La contraseña debe tener al menos 6 caracteres");
    return;
  }

  if (password !== passwordConfirm) {
    showPasswordError("Las contraseñas no coinciden");
    return;
  }

  hidePasswordError();

  try {
    // Mostrar estado de carga
    showState(sendingState);

    // Cambiar la contraseña
    const { error } = await supabase.auth.updateUser({
      password: password,
    });

    if (error) {
      throw error;
    }

    // Éxito
    showState(successState);

    // Guardar en sessionStorage que el reset fue exitoso
    sessionStorage.setItem("passwordReset", "success");
  } catch (error) {
    console.error("Error al cambiar contraseña:", error);

    let errorMsg = "No se pudo cambiar la contraseña. Intenta de nuevo.";

    if (error.message.includes("password")) {
      errorMsg = "Error con la contraseña: " + error.message;
    } else if (error.message.includes("session")) {
      errorMsg = "Tu sesión ha expirado. Solicita un nuevo enlace.";
    }

    errorMessage.textContent = errorMsg;
    showState(errorState);
  }
});

// ========================================
// VALIDACIÓN DEL TOKEN Y SESIÓN
// ========================================

async function validateSession() {
  try {
    // Obtener la sesión actual
    const {
      data: { session },
      error,
    } = await supabase.auth.getSession();

    if (error) {
      throw error;
    }

    if (!session) {
      // No hay sesión - probablemente link expirado
      errorMessage.textContent =
        "Tu enlace de recuperación ha expirado. Por favor, solicita uno nuevo.";
      showState(errorState);
      return false;
    }

    // Hay sesión válida - mostrar formulario
    showState(formState);
    passwordInput.focus();
    return true;
  } catch (error) {
    console.error("Error validating session:", error);
    errorMessage.textContent = error.message || "Error al validar tu sesión.";
    showState(errorState);
    return false;
  }
}

// ========================================
// RECUPERACIÓN DE CONTRASEÑA
// ========================================

async function sendRecoveryEmail() {
  const email = prompt("Ingresa tu email:");

  if (!email) {
    return;
  }

  try {
    showState(sendingState);

    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: REDIRECT_BASE_URL + "reset-password.html",
    });

    if (error) {
      throw error;
    }

    // Éxito
    const messageDiv = document.createElement("div");
    messageDiv.innerHTML = `
            <div style="background-color: #DBEAFE; border: 1px solid #BFDBFE; color: #1E40AF; padding: 16px; border-radius: 8px; margin-bottom: 16px;">
                ✅ Enviamos un enlace de recuperación a <strong>${email}</strong>
            </div>
        `;

    loadingState.parentNode.insertBefore(messageDiv, loadingState.nextSibling);
    setTimeout(() => {
      showState(loadingState);
    }, 3000);
  } catch (error) {
    console.error("Error sending recovery email:", error);
    errorMessage.textContent = "Error al enviar email: " + error.message;
    showState(errorState);
  }
}

// ========================================
// ACCIÓN DE ABRIR LA APP
// ========================================

function openApp() {
  // Opción 1: Redirigir a la app (si tienes un deep link)
  // window.location.href = 'app-pedidos://login';

  // Opción 2: Abrir URL web
  // window.location.href = 'https://app-pedidos.web.app';

  // Opción 3: Mostrar instrucciones
  alert(
    "Tu contraseña ha sido restablecida exitosamente.\n\n" +
      'Por favor, abre la app "App Pedidos" e inicia sesión con tu nueva contraseña.'
  );

  // Limpiar sessionStorage
  sessionStorage.removeItem("passwordReset");
}

// ========================================
// INICIALIZACIÓN
// ========================================

async function init() {
  console.log("Inicializando página de reset de contraseña...");
  console.log("SUPABASE_URL:", SUPABASE_URL);
  console.log("REDIRECT_BASE_URL:", REDIRECT_BASE_URL);

  // Esperar a que Supabase esté listo
  setTimeout(async () => {
    await validateSession();
  }, 500);
}

// Ejecutar cuando el DOM esté listo
document.addEventListener("DOMContentLoaded", init);

// ========================================
// SOPORTE PARA ENLACES DEEP
// ========================================

// Si se abre desde la app con token en la URL:
// app-pedidos://reset?token=...&type=recovery
window.addEventListener("message", (event) => {
  if (event.data && event.data.type === "SUPABASE_TOKEN") {
    console.log("Token recibido de la app");
    validateSession();
  }
});
