<template>
  <v-toolbar app fixed flat color="transparent">
    <v-toolbar-items>
      <v-btn flat class="headline pink--text--accent-2 font-weight-bold" href="/">
        {{token}}
      </v-btn>
    </v-toolbar-items>    
<!-- searchBox     -->
    <v-spacer></v-spacer>
    <v-toolbar-items class="hidden-sm-and-down">
<!-- all user btns       -->
      <v-btn
        class="pink accent-2 white--text"
        v-for="(btn, i) in btns"
        fab
        ma-1
        :key="i"  
        :to="btn.href"
        >
        <v-icon>{{btn.icon}}</v-icon>
      </v-btn>
<!-- user btns -->
      <div v-if="token">
        <v-btn
          class="pink accent-2 white--text"
          v-for="(btn, i) in userBtns"
          fab
          ma-1
          :key="i"  
          :to="btn.href"
          >
          <v-icon>{{btn.icon}}</v-icon>
        </v-btn>
      </div>
<!-- guesst btns       -->
      <div v-else>
        <v-btn
          class="pink accent-2 white--text"
          v-for="(btn, i) in guesstBtns"
          fab
          ma-1
          :key="i"  
          :to="btn.href"
          >
          <v-icon>{{btn.icon}}</v-icon>
        </v-btn>
      </div>
    </v-toolbar-items>
  </v-toolbar>
</template>

<script>

  export default {
    data: () => ({
      title: "Respect!",
      drawer: false,
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
        { title: 'Logout', icon: 'mdi-logout', href:'/post-tmp' },        
      ],
      searchWord: ""
    }),

    //
    computed: {
     token: { get() {return this.$store.getters.token} } 
    },

    //
    methods: {
      searchDialog() {

      }
    }
  }
</script>

<style>
a {
  text-decoration: none;
}

</style>
