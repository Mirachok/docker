<template>
  <div class="card" style="max-width:520px;margin:0 auto;">
    <h2>Регистрация</h2>
    <div style="display:grid;gap:10px;">
      <input v-model="username" placeholder="Логин">
      <input v-model="password" type="password" placeholder="Пароль">
      <button class="btn" @click="reg">Создать</button>

      <div v-if="msg" style="color:#0b6b00;font-weight:800;">{{ msg }}</div>
      <div v-if="err" style="color:#b00020;font-weight:800;">{{ err }}</div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { api } from "../api.js";

const username = ref("");
const password = ref("");
const msg = ref("");
const err = ref("");

async function reg(){
  msg.value=""; err.value="";
  try{
    await api("/auth/register", {
      method:"POST",
      body: JSON.stringify({ username: username.value, password: password.value })
    });
    msg.value="Готово. Теперь зайди через Вход.";
  }catch(e){
    err.value=e.message;
  }
}
</script>