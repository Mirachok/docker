<template>
  <div class="card">
    <h2>Студенты</h2>

    <div v-if="!isAuth" style="font-weight:800;">
      Нужно войти: <router-link to="/login">Вход</router-link>
    </div>

    <template v-else>
      <div v-if="role==='admin'" style="margin:10px 0;">
        <button class="btn" @click="$router.push('/students/add')">➕ Добавить</button>
      </div>

      <div v-if="err" style="color:#b00020;font-weight:800;">{{ err }}</div>

      <div class="tableWrap">
        <table>
          <thead>
            <tr>
              <th class="photoCell">Фото</th><th>ФИО</th><th>Группа</th><th>Действия</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="s in list" :key="s.id">
              <td class="photoCell">
                <img class="photo" :src="`/uploads/${s.photo || 'no-photo.svg'}`" />
              </td>
              <td>{{ s.last_name }} {{ s.first_name }} {{ s.middle_name }}</td>
              <td>{{ s.group_name }}</td>
              <td class="actions">
                <button title="Просмотр" @click="$router.push(`/students/${s.id}`)">👁</button>
                <button v-if="role==='admin'" title="Редактировать" @click="$router.push(`/students/${s.id}/edit`)">✏️</button>
                <button v-if="role==='admin'" title="Удалить" @click="del(s.id)">🗑</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { api } from "../api.js";

const list = ref([]);
const err = ref("");
const role = ref(localStorage.getItem("role") || "");
const isAuth = computed(() => !!localStorage.getItem("token"));

async function load() {
  if (!isAuth.value) return;
  err.value = "";
  try { list.value = await api("/students"); }
  catch (e) { err.value = e.message; }
}

async function del(id) {
  if (!confirm("Удалить запись?")) return;
  try { await api(`/students/${id}`, { method: "DELETE" }); await load(); }
  catch (e) { err.value = e.message; }
}

onMounted(load);
</script>