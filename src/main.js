import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import router from './router.js' //import VueRouter
import store from './store.js' //import vuex as store

Vue.config.productionTip = false

new Vue({
  store,
  router,
  render: h => h(App),
}).$mount('#app')
