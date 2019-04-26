import Vue from 'vue'
import VueRouter from 'vue-router'

//// below You want to read component routing
import Top from './components/Top.vue'
import SignIn from './components/SignIn.vue'
import SignUp from './components/SignUp.vue'
import PostModal from "./components/Modal"
import PostModal1 from "./components/Modal1";

// regist as plugin
Vue.use(VueRouter)

const router = new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      component: Top,
      children: [
        { name: "post-register", path: "", component: PostModal },
        { name: "post-tmp", path: "tmp", component: PostModal1 },
      ]
    },
    { path: "/signin", component: SignIn },
    { path: "/signup", component: SignUp }
  ]
});

// VueRouter instance export
export default router