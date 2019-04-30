<template>
  <v-toolbar app fixed flat color="transparent">
    <v-toolbar-items>
      <v-btn flat class="headline pink--text--accent-2 font-weight-bold" href="/">
        {{token}}
      </v-btn>
    </v-toolbar-items>
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
        {{btn.title}}
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
          {{btn.title}}
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
          {{btn.title}}
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
        { title: 'Map', icon: 'add_location', href:'/'},
        { title: 'Search', icon: 'search' },
      ],
      guesstBtns:[
        { title: 'SignUp', icon: 'mdi-user-add', href:'/signup' },
        { title: 'SignIn', icon: '', href:'/signin' },
         { title: 'About', icon: '', href:'' },
      ],
      userBtns:[
        { title: 'Mypage', icon: 'question_answer', href:'/post-tmp' },
        { title: 'Logout', icon: 'question_answer', href:'/post-tmp' },        
      ],
    }),

    computed: {
     token: { get() {return this.$store.getters.token} } 
    }
  }
</script>

<style>
a {
  text-decoration: none;
}
</style>
