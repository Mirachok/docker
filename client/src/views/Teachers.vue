<template>
  <div class="card">
    <h2>Преподаватели</h2>

    <div v-if="!isAuth" style="font-weight:800;">
      Нужно войти: <router-link to="/login">Вход</router-link>
    </div>

    <template v-else>
      <div v-if="role==='admin'" style="margin:10px 0;">
        <button class="btn" @click="$router.push('/teachers/add')">➕ Добавить</button>
      </div>

      <div v-if="err" style="color:#b00020;font-weight:800;">{{ err }}</div>

      <div class="tableWrap">
        <table>
          <thead>
            <tr>
              <th class="photoCell">Фото</th><th>ФИО</th><th>Должность</th><th>Действия</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="t in list" :key="t.id">
              <td class="photoCell">
                <img class="photo" :src="`/uploads/${t.photo || 'no-photo.svg'}`" />
              </td>
              <td>{{ t.last_name }} {{ t.first_name }} {{ t.middle_name }}</td>
              <td>{{ t.position }}</td>
              <td class="actions">
                <button title="Просмотр" @click="$router.push(`/teachers/${t.id}`)">👁</button>
                <button v-if="role==='admin'" title="Редактировать" @click="$router.push(`/teachers/${t.id}/edit`)">✏️</button>
                <button v-if="role==='admin'" title="Удалить" @click="del(t.id)">🗑</button>
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
  try { list.value = await api("/teachers"); }
  catch (e) { err.value = e.message; }
}

async function del(id) {
  if (!confirm("Удалить запись?")) return;
  try { await api(`/teachers/${id}`, { method: "DELETE" }); await load(); }
  catch (e) { err.value = e.message; }
}

onMounted(load);
</script>