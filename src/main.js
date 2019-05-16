import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import router from './router.js' //import VueRouter
import store from './store.js' //import vuex as store
import AOS from 'aos'
import "aos/dist/aos.css";

Vue.config.productionTip = false

new Vue({
  created() {
    AOS.init();
  },
  store,
  router,
  render: h => h(App),
}).$mount('#app')
