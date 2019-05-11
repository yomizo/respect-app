<template>
  <v-toolbar app fixed flat color="transparent">
<!-- searchBox     -->
    <v-spacer></v-spacer>
    <v-toolbar-items class="hidden-sm-and-down">
<!-- all user btns       -->
      <v-tooltip
        bottom
        v-for="(btn, i) in btns"
        :key="i">
        <template v-slot:activator="{on}">
          <v-btn
            v-on="on"
            class="pink accent-2 white--text"
            fab
            ma-1
            :to="btn.href"
            >
            <v-icon>{{btn.icon}}</v-icon>
          </v-btn>
        </template>
        <span>{{btn.title}}</span>
      </v-tooltip>
<!-- user btns -->
      <div v-if="token">
        <v-tooltip
          bottom
          >
          <template v-slot:activator="{on}">
            <v-btn
              @click="mypage"
              v-on="on"
              class="pink accent-2 white--text"
              fab
              ma-1
              >
              <v-icon>mdi-settings</v-icon>
            </v-btn>
          </template>
          <span>マイページ</span>
        </v-tooltip>
        <v-tooltip
          bottom
          >
          <template v-slot:activator="{on}">
            <v-btn
              @click="logout"
              v-on="on"
              class="pink accent-2 white--text"
              fab
              ma-1
              to="/"
              >
              <v-icon>mdi-logout</v-icon>
            </v-btn>
          </template>
          <span>ログアウト</span>
        </v-tooltip>        
      </div>
<!-- guesst btns       -->
      <div v-else>
        <v-tooltip
          bottom
          v-for="(btn, i) in guesstBtns"
          :key="i">
          <template v-slot:activator="{on}">
            <v-btn
              v-on="on"
              class="pink accent-2 white--text"
              fab
              ma-1
              :to="btn.href"
              >
              <v-icon>{{btn.icon}}</v-icon>
            </v-btn>
          </template>
          <span>{{btn.title}}</span>
        </v-tooltip>
      </div>      
    </v-toolbar-items>
    <v-toolbar-items class="hidden-md-and-up">
      <Menu/>
    </v-toolbar-items>
  </v-toolbar>
</template>

<script>
import Menu from "./Menu"

  export default {
    components: {Menu},
    data: () => ({
      title: "Respect!",
      // drawer: false,
      btns: [
        { title: 'Map', icon: 'mdi-google-maps', href:'/'},
      ],
      guesstBtns:[
        { title: 'SignUp', icon: 'mdi-account-plus', href:'/signup' },
        { title: 'SignIn', icon: 'mdi-login', href:'/signin' },
        { title: 'About', icon: 'mdi-information', href:'' },
      ],
      userBtns:[
        { title: 'Mypage', icon: 'mdi-settings', href:'/post-tmp' },      
      ],
      searchWord: ""
    }),

    //
    computed: {
      token: { get() {return this.$store.getters.token} },   
    },

    //
    methods: {
      logout() {
        this.$store.commit('updateToken', {token: null})
        this.$store.commit('updateUserId', {userId: null})
        this.$store.commit('updateUserData', null)
        this.$store.commit('updateFlash', "ログオフしました")
        this.$store.commit('updateIsSnackBar')
        this.$store.commit('updateSnackBarColor', {color: "#FF1744"})
      },
      mypage() {
        this.$store.dispatch('showUser', "/users/")
      },
    }
  }
</script>

<style>
a {
  text-decoration: none;
}

</style>
