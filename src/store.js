import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from './router.js'
// import createPersistedState from "vuex-persistedstate";

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
    token: "",
    postData: null,
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
    searchList(state) {
      return state.searchList;
    },
    flash(state) {
      return state.flash;
    },
    isPrivate(state) {
      return state.isPrivate;
    },
    postData(state) {
      return state.postData;
    },
    //#######develop only###########
    token(state) {
      return state.token;
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
      state.postData = payload.postData
      console.log(state.postData)
    },

    //set search_list
    updateSearchList(state, payload) {
      axios
        .get(URL_BASE + payload.url)
        .then(res => {
          state.searchList = res.data.posts;
        })
        .catch(error => {
          console.log(error);
        });
    },

    // signup
    register(state, payload) {
      axios
        .post(URL_BASE + payload.url, {
          user: payload.params
        })
        .then(res => {
          console.log(res.data);
          state.flash = "Registration is done"; //update flash message
          router.push("/"); //redirect
          state.isPrivate = true; //change private
          state.token = res.data;
        })
        .catch(error => {
          console.log(error);
          state.flash = "Registration is false"; //update flash message
        });
    },

    // signin
    signin(state, payload) {
      axios
        .post(URL_BASE + payload.url, {
          user: payload.params
        })
        .then(res => {
          // console.log(res.data);
          state.flash = "Success Signin";
          router.push("/");
          state.isPrivate = true;
          state.token = res.data;
        })
        .catch(error => {
          // console.log(error);
          state.flash = "Sorry failed";
        });
    },

    // create post
    createPost(state, payload) {
      // axios.defaults.headers.common['Authorization'] = state.token
      axios
        .post(URL_BASE + payload.url, {
          post: payload.params
        },
          { headers: { "Authorization": `Token ${state.token}` } }
        )
        .then(res => {
          // console.log(res.data);
          state.flash = "Posted!";
          router.push("/");
        })
        .catch(error => {
          console.log(error);
          state.flash = "Post is failed";
        });
    }
  },

  actions: {
    setDialog({ commit }) {
      commit("updateDialog");
    },
    setMarker({ commit }, [tempMarker, map]) {
      // console.log("get");
      commit("updateMarker", { tempMarker, map });
    },
    setPosts({ commit }, url) {
      commit("updateSearchList", { url });
    },
    setPostData({ commit }, postData) {
      commit("updatePostData", { postData })
    },
    registerUser({ commit }, [url, params]) {
      commit("register", { url, params })
    },
    signinUser({ commit }, [url, params]) {
      commit("signin", { url, params })
    },
    createPost({ commit }, [url, params]) {
      commit("createPost", { url, params })
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