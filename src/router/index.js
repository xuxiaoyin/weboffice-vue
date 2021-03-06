import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    path: '/office',
    name: 'Office',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "office" */ '../views/Office.vue')
  },
  {
    path: '/fullcalendar',
    name: 'Fullcalendar',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "fullcalendar" */ '../views/Fullcalendar.vue')
  },
  {
    path: '/pdf',
    name: 'Pdf',
    component: () => import(/* webpackChunkName: "pdf" */ '../views/Pdf.vue')
  },
  // ProjectList
  {
    path: '/projectList',
    name: 'ProjectList',
    component: () => import(/* webpackChunkName: "projectList" */ '../views/ProjectList.vue')
  },
  {
    path: '/rights',
    name: 'Rights',
    component: () => import(/* webpackChunkName: "projectList" */ '../views/Rights.vue')
  },
  {
    path: '/rightsCopy',
    name: 'RightsCopy',
    component: () => import(/* webpackChunkName: "projectList" */ '../views/RightsCopy.vue')
  },
]

const router = new VueRouter({
  mode: 'hash',
  base: process.env.BASE_URL,
  routes
})

export default router
