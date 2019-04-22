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
    }
  },

  actions: {
    setDialog({ commit }, [tempMarker, map]) {
      commit('updateDialog', { tempMarker, map })
    },
    setPosts({ commit }, url) {
      commit('updateSearchList', { url })
    }
  }
})


export default store