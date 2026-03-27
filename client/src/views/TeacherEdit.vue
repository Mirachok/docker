<template><TeacherForm mode="edit" :id="route.params.id" /></template>
<script setup>
import { useRoute } from "vue-router";
import TeacherForm from "./TeacherForm.vue";
const route = useRoute();
</script>