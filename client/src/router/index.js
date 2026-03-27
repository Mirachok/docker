import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import About from "../views/About.vue";
import Contacts from "../views/Contacts.vue";

import Students from "../views/Students.vue";
import StudentDetail from "../views/StudentDetail.vue";
import StudentAdd from "../views/StudentAdd.vue";
import StudentEdit from "../views/StudentEdit.vue";

import Teachers from "../views/Teachers.vue";
import TeacherDetail from "../views/TeacherDetail.vue";
import TeacherAdd from "../views/TeacherAdd.vue";
import TeacherEdit from "../views/TeacherEdit.vue";

import Login from "../views/Login.vue";
import Register from "../views/Register.vue";

export default createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", component: Home },
    { path: "/about", component: About },
    { path: "/contacts", component: Contacts },

    { path: "/students", component: Students },
    { path: "/students/add", component: StudentAdd },
    { path: "/students/:id", component: StudentDetail },
    { path: "/students/:id/edit", component: StudentEdit },

    { path: "/teachers", component: Teachers },
    { path: "/teachers/add", component: TeacherAdd },
    { path: "/teachers/:id", component: TeacherDetail },
    { path: "/teachers/:id/edit", component: TeacherEdit },

    { path: "/login", component: Login },
    { path: "/register", component: Register }
  ]
});