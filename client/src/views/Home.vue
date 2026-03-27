<template>
  <div class="card" style="text-align:center;">
    <h1>{{ title }}</h1>
    <p>Главная страница проекта на UBUNTU 25.04.</p>
  </div>
</template>

<script setup>
import { onMounted, ref } from "vue";
const title = ref("АПТ");
onMounted(async () => {
  const r = await fetch("/api/info");
  title.value = (await r.json()).title;
});
</script>