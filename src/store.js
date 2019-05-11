import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import VueAxios from 'vue-axios' // Vue.prototype.$axios
import router from './router.js'
// import createPersistedState from "vuex-persistedstate";

// config
const URL_BASE = 'http://localhost:3000'
const IMAGEDIR = "/user_images/"
const SUCCESS = "#009688"
const DANGER = "#FF1744"

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
    isSnackBar: false,
    snackBarColor: SUCCESS,
    token: null,
    postData: null,
    userId: null,
    userData: null
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
      return state.userId;
    },
    userData(state) {
      return state.userData;
    },
    isSnackBar(state) {
      return state.isSnackBar;
    },
    snackBarColor(state) {
      return state.snackBarColor;
    },
    imageAddress() {
      return URL_BASE + IMAGEDIR;
    }
  },

  mutations: {
    updateDialog(state) {
      state.dialog = !state.dialog;
    },
    updateMap(state, payload) {
      state.map = payload.map;
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
      state.userId = payload.userId;
    },
    updateUserData(state, payload) {
      state.userData = payload;
    },
    updateMarkers(state, payload) {
      state.markerList = payload.posts;
    },
    updateIsSnackBar(state) {
      state.isSnackBar = !state.isSnackBar;
    },
    updateSnackBarColor(state, payload) {
      state.snackBarColor = payload.color;
    },
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
    // setPostData({ commit}, postData) {
    //   commit("updatePostData", { postData });
    //               },
    //
    setPostData(context, url) {
      axios
        .get(URL_BASE + url, {})
        .then(res => {
          context.commit("updatePostData", { postData: res.data });
          context.commit("updateDialog");
          router.push("/postshow");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", "投稿が見つかりません");
        });
    },

    // Read initial markerList in DB
    markerList(context, [url, params]) {
      axios
        .post(URL_BASE + url + "/search", params)
        .then(res => {
          context.commit("updateMarkers", { posts: res.data });
        })
        .catch(error => {
          context.commit("updateFlash", "Refresh Browser");
        });
    },

    // user create
    signup(context, [url, params]) {
      axios
        .post(URL_BASE + url, { user: params })
        .then(res => {
          // flash message
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: SUCCESS });
          context.commit("updateFlash", "Welcome Respectful world!");
          // authentication
          context.commit("updateToken", { token: res.data.token });
          context.commit("updateUserId", { userId: res.data.id });
          router.push("/");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", error.response.data.error);
        });
    },

    // user authentication
    signin(context, [url, params]) {
      axios
        .post(URL_BASE + url, { user: params })
        .then(res => {
          // flash message
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: SUCCESS });
          context.commit("updateFlash", "Signin Success!");
          // authentication
          context.commit("updateToken", { token: res.data.token });
          context.commit("updateUserId", { userId: res.data.id });
          context.commit("updateUserData", res.data)
          router.push("/");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", error.response.data.error);
        });
    },

    // user show
    showUser(context, url) {
      axios
        .get(URL_BASE + url + context.state.userId, {
          headers: { Authorization: `Token ${context.state.token}` }
        })
        .then(res => {
          context.commit("updateUserData", res.data);
          context.commit("updateDialog");
          router.push("/mypage");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", "ユーザーが見つかりません");
        });
    },

    //
    editUser(context, [url, params]) {
      axios
        .patch(
          URL_BASE + url + context.state.userId,
          { user: params },
          { headers: { Authorization: `Token ${context.state.token}` } }
        )
        .then(res => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: SUCCESS });
          context.commit("updateFlash", "Edit Complete!");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", error.response.data.error);
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
          // flash message
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: SUCCESS });
          context.commit("updateFlash", "Post is created!");
          // update markerlist
          let latLng = { lat: params.lat, lng: params.lng };
          context.dispatch("markerList", [url, latLng]);
          // redirect
          router.push("/");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", error.response.data.error);
        });
    },

    // post delete
    deletePost(context, url) {
      axios
        .delete(URL_BASE + url, {
          headers: { Authorization: `Token ${context.state.token}` }
        })
        .then(res => {
          // flash message
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: SUCCESS });
          context.commit("updateFlash", "Post is deleted!");
          // redirect
          router.push("/");
          context.commit("updateDialog");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", error.response.data.error);
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
          // flash message
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: SUCCESS });
          context.commit("updateFlash", "Edit Complete!");
          // redirect
          router.push("/postshow");
        })
        .catch(error => {
          context.commit("updateIsSnackBar");
          context.commit("updateSnackBarColor", { color: DANGER });
          context.dispatch("chooseError", error.response.data.error);
        });
    },

    // Error Common process
    chooseError(context, error) {
      let flash = "";
      if (typeof error == "object") {
        Object.keys(error).forEach(function(key) {
          flash += key + ": " + error[key] + "\n";
        });
      } else if (typeof error == "string") {
        flash = error;
      } else {
        flash = "Server doesn't respond. Sorry m(__)m";
      }
      context.commit("updateFlash", flash);
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