import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

const URL_BASE = 'http://localhost:3000'
//registor as plugin
Vue.use(Vuex)
Vue.use(axios)

//make the store
const store = new Vuex.Store({
  
  state: {
    dialog: false,
    map: null,
    marker: null,
    searchList: null,
    flash: null,
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
          console.log('Sended' + res.data)
          state.flash = "Registration is done"
        }).catch(error => {
          console.log(error)
          state.flash = "Registration is false"
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