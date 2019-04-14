import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
//import vuex as store
import store from './store.js'

Vue.config.productionTip = false

new Vue({
  store,
  render: h => h(App),
}).$mount('#app')
