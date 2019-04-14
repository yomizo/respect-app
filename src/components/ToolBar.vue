<template>
  <v-layout>
    <v-toolbar app fixed dense clipped-left class="deep-orange">
      <v-toolbar-title class="headline text-uppercase">
        <span><a class="white--text" href="#top">{{title}}</a></span>
        <span class="font-weight-light">{{subtitle}}</span>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn round class="deep-orange--text" @click.stop="doUpdate">
        <v-avatar size="26">
          <img src="heart55.png" alt="avatar">
        </v-avatar>        
        Respect!
      </v-btn>
      <v-toolbar-items class="hidden-sm-and-down">
        <v-btn
          class="white--text" 
          v-for="(mn, i) in items" 
          :key="i"  
          :href="mn.href"
          flat>
          {{mn.title}}
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
      items: [
        { title: 'About', icon: 'question_answer', href:'#about' },
        { title: 'Login', icon: 'dashboard', href:'#login' },
        { title: 'Signin', icon: 'question_answer', href:'#signin' },
        // { title: 'Skills', icon: 'question_answer', href:'#skills' },
        // { title: 'History', icon: 'question_answer', href:'#history' },
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
