<template><StudentForm mode="edit" :id="route.params.id" /></template>
<script setup>
import { useRoute } from "vue-router";
import StudentForm from "./StudentForm.vue";
const route = useRoute();
</script>