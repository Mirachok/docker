<template>
  <div class="card" style="max-width:520px;margin:0 auto;">
    <h2>Вход</h2>
    <div style="display:grid;gap:10px;">
      <input v-model="username" placeholder="Логин">
      <input v-model="password" type="password" placeholder="Пароль">
      <button class="btn" @click="login">Войти</button>
      <div v-if="err" style="color:#b00020;font-weight:800;">{{ err }}</div>
      <div style="font-size:14px;">Админ по умолчанию: <b>admin / admin123</b></div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { api } from "../api.js";
const username = ref(""); const password = ref(""); const err = ref("");
async function login() {
  err.value="";
  try {
    const d = await api("/auth/login",{method:"POST",body:JSON.stringify({username:username.value,password:password.value})});
    localStorage.setItem("token", d.token);
    localStorage.setItem("role", d.role);
    location.href="/";
  } catch(e){ err.value=e.message; }
}
</script>