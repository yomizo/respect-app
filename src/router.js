import Vue from 'vue'
import VueRouter from 'vue-router'
import store from './store.js'

//// below You want to read component routing
import About from './components/About.vue'
import SignIn from './components/SignIn.vue'
import SignUp from './components/SignUp.vue'

// regist as plugin
Vue.use(VueRouter)
Vue.use(store)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: About },
    { path: '/signin', component: SignIn },
    { path: '/signup', component: SignUp },
    // { path: '/users', component: MyPage },
  ]
})

// VueRouter instance export
export default router