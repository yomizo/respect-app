<template>
  <v-layout>
    <v-toolbar app fixed dense clipped-left class="pink lighten-5">
      <v-toolbar-items class="text-uppercase">
        <v-btn flat class="headline grey--text--darken-3 font-weight-bold" href="#top">
          {{title}}
        </v-btn>
      </v-toolbar-items>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-sm-and-down">
        <v-btn
          class="grey--text--darken-3" 
          v-for="(btn, i) in btns" 
          :key="i"  
          :to="btn.href"
          flat>
          {{btn.title}}
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>
  </v-layout>
</template>

<script>

  export default {
    data: () => ({
      title: "Respect!",
      subtitle:"",
      drawer: false,
      btns: [
        { title: 'About', icon: 'question_answer', href:'/' },
        { title: 'SignUp', icon: 'dashboard', href:'/signup' },
        { title: 'SignIn', icon: 'question_answer', href:'/signin' },
        { title: 'Mypage', icon: 'question_answer', href:'#mypage' },        
      ],
      mini: false,
      right: null
    }),
    methods: {
      doUpdate(event) {
        this.$store.dispatch('doUpdate')
      }
    }
  }
</script>

<style>
a {
  text-decoration: none;
}
</style>
