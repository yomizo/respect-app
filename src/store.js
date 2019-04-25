import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from './router.js'


const URL_BASE = 'http://localhost:3000'
//registor as plugin
Vue.use(Vuex)
Vue.use(axios)
Vue.use(router)

//make the store
const store = new Vuex.Store({
  
  state: {
    dialog: false,
    map: null,
    marker: null,
    searchList: null,
    flash: null,
    isPrivate: false,
  },

  getters: {
    dialog(state) {
      return state.dialog
    },
    marker(state) {
      return state.marker
    },
    map(state) {
      return state.map
    },
    searchList(state) {
      return state.searchList
    },
    flash(state) {
      return state.flash
    },
    isPrivate(state) {
      return state.isPrivate
    }
  },

  mutations: {
    updateDialog (state, payload){
      state.dialog = !state.dialog
      state.marker = payload.tempMarker
      state.map = payload.map
    },
    //set search_list
    updateSearchList(state, payload) {
      axios.get(URL_BASE + payload.url)
        .then((res) => {
          state.searchList = res.data.posts
        }).catch((error) => {
          console.log(error)
        })
    },
    updateFlash(state, payload) {
      axios.post(URL_BASE + payload.url, {
          user: payload.params
        })
        .then((res) => {
          console.log(res)
          state.flash = "Registration is done" //update flash message
          router.push('/') //redirect
          state.isPrivate = true //change private
        }).catch(error => {
          console.log(error)
          state.flash = "Registration is false" //update flash message
        })
    }
  },

  actions: {
    setDialog({ commit }, [tempMarker, map]) {
      commit('updateDialog', { tempMarker, map })
    },
    setPosts({ commit }, url) {
      commit('updateSearchList', { url })
    },
    setUser({ commit }, [url, params]) {
      commit('updateFlash', { url, params })
    }
  }
})


export default store