import Vue from 'vue'
import Vuex from 'vuex'

//registor as plugin
Vue.use(Vuex)

//make the store
const store = new Vuex.Store({
  state: {
    dialog: false,
    map: null,
    marker: null
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
  },
  mutations: {
    toggle (state, payload){
      state.dialog = !state.dialog
      state.marker = payload.tempMarker
      state.map = payload.map
    },
  },
  actions: {
    doUpdate({ commit }, [tempMarker, map]) {
      commit('toggle', { tempMarker, map })
      // tempMarker.setMap(null)
    }
  }
})

// watch function
// const unwatch = store.watch(
//   (state, getters) => {
//     return state.dialog
//   },
//   (newValue, oldValue) => {
//     state.marker.setMap(null)
//   }
// )

export default store