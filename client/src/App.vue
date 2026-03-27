<template>
  <div class="layout">
    <header class="header">
      <div class="brand">АПТ</div>
      <nav class="nav">
        <router-link to="/">Главная</router-link>
        <router-link to="/about">О нас</router-link>
        <router-link to="/contacts">Контакты</router-link>
        <router-link to="/students">Студенты</router-link>
        <router-link to="/teachers">Преподаватели</router-link>

        <span v-if="isAuth" class="badge">{{ role==='admin' ? 'Админ' : 'Пользователь' }}</span>

        <router-link v-if="!isAuth" to="/login">Вход</router-link>
        <router-link v-if="!isAuth" to="/register">Регистрация</router-link>
        <a v-if="isAuth" href="#" @click.prevent="logout">Выйти</a>
      </nav>
    </header>

    <main class="main"><router-view /></main>
    <footer class="footer">Docker + Vue 3 + Node + MySQL</footer>
  </div>
</template>

<script setup>
import { computed, ref } from "vue";
const role = ref(localStorage.getItem("role") || "");
const isAuth = computed(() => !!localStorage.getItem("token"));
function logout() {
  localStorage.removeItem("token");
  localStorage.removeItem("role");
  location.href = "/";
}
window.addEventListener("storage", () => role.value = localStorage.getItem("role") || "");
</script>