import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import VueAxios from 'vue-axios' // Vue.prototype.$axios
import router from './router.js'
// import createPersistedState from "vuex-persistedstate";

const URL_BASE = 'http://localhost:3000'
//registor as plugin
Vue.use(Vuex)
Vue.use(VueAxios, axios)
Vue.use(router)

//make the store
const store = new Vuex.Store({
  state: {
    dialog: false,
    map: null,
    marker: null,
    markerList: null,
    flash: null,
    token: null,
    postData: null,
    userId: null,
  },

  getters: {
    dialog(state) {
      return state.dialog;
    },
    marker(state) {
      return state.marker;
    },
    map(state) {
      return state.map;
    },
    markerList(state) {
      return state.markerList;
    },
    flash(state) {
      return state.flash;
    },
    postData(state) {
      return state.postData;
    },
    token(state) {
      return state.token;
    },
    userId(state) {
      return state.userId
    }
  },

  mutations: {
    updateDialog(state) {
      state.dialog = !state.dialog;
    },
    updateMarker(state, payload) {
      state.marker = payload.tempMarker;
      state.map = payload.map;
    },
    updatePostData(state, payload) {
      state.postData = payload.postData;
    },
    updateComment(state, payload) {
      state.postData.comment = payload.comment;
    },
    updateToken(state, payload) {
      state.token = payload.token;
    },
    updateUserId(state, payload) {
      state.userId = payload.userId
    },
    updateMarkers(state, payload) {
      state.markerList = payload.posts
    },

    // update flash
    updateFlash(state, payload) {
      state.flash = payload;
    }
  },

  actions: {

    // setOnly
    setDialog({ commit }) {
      commit("updateDialog");
    },
    setMarker({ commit }, [tempMarker, map]) {
      commit("updateMarker", { tempMarker, map });
    },
    setPostData({ commit }, postData) {
      commit("updatePostData", { postData });
    },

    // Read initial markerList in DB
    markerList(context, url) {
      axios.get(URL_BASE + url)
        .then(res => {
          context.commit('updateMarkers', { posts: res.data.posts })
        }).catch(error => {
          context.commit('updateFlash', "Refresh Browser")
      })
    },

    // user create
    signup(context, [url, params]) {
      axios
        .post(URL_BASE + url, { user: params })
        .then(res => {
          context.commit("updateFlash", "Welcome Respectful world!")
          context.commit("updateToken", { token: res.data.token })
          context.commit('updateUserId', {userId: res.data.id})
          router.push("/");
        })
        .catch(error => {
          console.log(error.response.data.error.email[0])
          context.commit("updateFlash", "Sorry failed")
        });
    },

    // user authentication
    signin(context, [url, params]) {
      axios
        .post(URL_BASE + url, { user: params })
        .then(res => {
          context.commit("updateFlash", "Signin Success!")
          context.commit("updateToken", { token: res.data.token })
          context.commit("updateUserId", { userId: res.data.id })
          router.push("/");
        })
        .catch(error => {
          let flash = ""
          if (error.response.status == 422) {
            flash = "Authentication failed"
          } else {
            flash = "Server doesn't respond. Sorry m(__)m"
          }
          context.commit("updateFlash", flash);
        });
    },

    // post create
    createPost(context, [url, params]) {
      axios
        .post(
          URL_BASE + url,
          { post: params },
          { headers: { Authorization: `Token ${context.state.token}` } }
        )
        .then(res => {
          context.commit('updateFlash', "Post is created!");
          context.dispatch('markerList', url)
          router.push("/");
        })
        .catch(error => {
          context.commit('updateFlash', "Post failed!");
        });
    },

    // post delete
    deletePost(context, url) {
      axios
        .delete(URL_BASE + url, {
          headers: { Authorization: `Token ${context.state.token}` }
        })
        .then(res => {
          context.commit("updateFlash", "Post is deleted!");
        })
        .catch(error => {
          context.commit("updateFlash", "Delete failed!");
        });
    },

    // post edit
    editPost(context, [url, comment]) {
      context.commit("updateComment", { comment });

      axios
        .patch(
          URL_BASE + url,
          { post: context.state.postData },
          { headers: { Authorization: `Token ${context.state.token}` } }
        )
        .then(res => {
          context.commit('updateFlash', "Edit Complete!");
          router.push("/postshow");
        })
        .catch(error => {
          context.commit("updateFlash", "Edit failed!");
        });
    }
  }

  // for sessionStorage
  // plugins: [createPersistedState({
  //   storage: window.sessionStorage,
  //   key: 'Respects!',
  //   paths: "state.token",
  // })]
});


export default store