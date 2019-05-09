import Vue from 'vue'
import VueRouter from 'vue-router'


//// Read component routing//////////////////
import Top from './components/Top.vue'
import SignIn from './components/SignIn.vue'
import SignUp from './components/SignUp.vue'
import Post from "./components/Post"
import PostShow from "./components/PostShow"
import PostEdit from "./components/PostEdit"
import SearchBox from "./components/SearchBox"
import MyPage from "./components/MyPage"

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
        { name: "postedit", path: "postedit", component: PostEdit },
        { name: "searchbox", path: "searchbox", component: SearchBox },
        { name: "mypage", path: "mypage", component: MyPage },
      ]
    },
    { path: "/signin", component: SignIn },
    { path: "/signup", component: SignUp }
  ]
});


// VueRouter instance export
export default router