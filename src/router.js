import Vue from 'vue'
import VueRouter from 'vue-router'

//// below You want to read component routing
import Top from './components/Top.vue'
import SignIn from './components/SignIn.vue'
import SignUp from './components/SignUp.vue'
import Post from "./components/Post"
import PostShow from "./components/PostShow";

// regist as plugin
Vue.use(VueRouter)

const router = new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      component: Top,
      children: [
        { name: "post", path: "", component: Post },
        { name: "postshow", path: "postshow", component: PostShow },
      ]
    },
    { path: "/signin", component: SignIn },
    { path: "/signup", component: SignUp }
  ]
});

// VueRouter instance export
export default router