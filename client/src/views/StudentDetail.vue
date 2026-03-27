<template>
  <div class="card">
    <h2>Детально: студент</h2>

    <div v-if="!isAuth" style="font-weight:800;">
      Нужно войти: <router-link to="/login">Вход</router-link>
    </div>

    <template v-else>
      <div v-if="err" style="color:#b00020;font-weight:800;">{{ err }}</div>

      <template v-if="item">
        <img class="photoLarge" :src="`/uploads/${item.photo || 'no-photo.svg'}`" />

        <div><b>Фамилия:</b> {{ item.last_name }}</div>
        <div><b>Имя:</b> {{ item.first_name }}</div>
        <div><b>Отчество:</b> {{ item.middle_name }}</div>
        <div><b>Группа:</b> {{ item.group_name }}</div>
        <div><b>Специальность:</b> {{ item.speciality }}</div>
        <div><b>Email:</b> {{ item.email }}</div>
        <div><b>Телефон:</b> {{ item.phone }}</div>

        <div style="margin-top:12px;">
          <button class="btn" @click="$router.push('/students')">← Назад</button>
          <button v-if="role==='admin'" class="btn" style="margin-left:8px;"
                  @click="$router.push(`/students/${item.id}/edit`)">✏️ Редактировать</button>
        </div>
      </template>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { useRoute } from "vue-router";
import { api } from "../api.js";

const route = useRoute();
const item = ref(null);
const err = ref("");

const role = ref(localStorage.getItem("role") || "");
const isAuth = computed(() => !!localStorage.getItem("token"));

async function load() {
  if (!isAuth.value) return;
  err.value = "";
  try { item.value = await api(`/students/${route.params.id}`); }
  catch (e) { err.value = e.message; }
}

onMounted(load);
</script>