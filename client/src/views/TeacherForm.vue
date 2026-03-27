<template>
  <div class="card">
    <h2>{{ mode==='add' ? 'Добавить преподавателя' : 'Редактировать преподавателя' }}</h2>

    <div v-if="!isAuth" style="font-weight:800;">
      Нужно войти: <router-link to="/login">Вход</router-link>
    </div>

    <div v-else-if="role!=='admin'" style="font-weight:800;">
      Только админ может добавлять/редактировать.
    </div>

    <template v-else>
      <div v-if="err" style="color:#b00020;font-weight:800;">{{ err }}</div>

      <div class="formRow">
        <input v-model="form.last_name" placeholder="Фамилия" />
        <input v-model="form.first_name" placeholder="Имя" />
        <input v-model="form.middle_name" placeholder="Отчество" />
        <input v-model="form.department" placeholder="Отдел" />
        <input v-model="form.position" placeholder="Должность" />
        <input v-model="form.email" placeholder="Email" />
        <input v-model="form.phone" placeholder="Телефон" />
        <input v-model="form.photo" placeholder="Фото (имя файла) или загрузить ниже" />
      </div>

      <div style="margin-top:10px;">
        <input type="file" @change="uploadFile" />
        <div style="font-size:14px;margin-top:6px;">
          Если загрузил файл — имя автоматически подставится в поле photo.
        </div>
      </div>

      <div style="margin-top:12px;">
        <button class="btn" @click="save">Сохранить</button>
        <button class="btn" style="margin-left:8px;background:#555;" @click="back">Отмена</button>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { api } from "../api.js";

const props = defineProps({
  mode: { type: String, required: true }, // 'add' | 'edit'
  id: { type: [String, Number], default: null }
});

const err = ref("");
const role = ref(localStorage.getItem("role") || "");
const isAuth = computed(() => !!localStorage.getItem("token"));

const form = ref({
  first_name:"", last_name:"", middle_name:"",
  department:"", position:"", email:"", phone:"",
  photo:"no-photo.svg"
});

async function loadForEdit() {
  if (props.mode !== "edit") return;
  try { form.value = await api(`/teachers/${props.id}`); }
  catch (e) { err.value = e.message; }
}

async function uploadFile(e) {
  const file = e.target.files?.[0];
  if (!file) return;

  err.value = "";
  try {
    const token = localStorage.getItem("token") || "";
    const fd = new FormData();
    fd.append("file", file);

    const res = await fetch("/api/upload", {
      method: "POST",
      headers: { Authorization: `Bearer ${token}` },
      body: fd
    });

    const data = await res.json();
    if (!res.ok) throw new Error(data?.message || "Upload error");
    form.value.photo = data.filename;
  } catch (ex) {
    err.value = ex.message;
  }
}

async function save() {
  err.value = "";
  try {
    if (props.mode === "add") {
      await api("/teachers", { method:"POST", body: JSON.stringify(form.value) });
    } else {
      await api(`/teachers/${props.id}`, { method:"PUT", body: JSON.stringify(form.value) });
    }
    location.href = "/teachers";
  } catch (e) {
    err.value = e.message;
  }
}

function back() { location.href = "/teachers"; }

onMounted(loadForEdit);
</script>