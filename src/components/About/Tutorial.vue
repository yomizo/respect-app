<template>
<v-layout id="tutorial" column py-5 class="pink lighten-5" justify-center>
  <v-flex py-4 class="display-2 font-weight-medium text-xs-center">
    <div data-aos="fade-up">
      <p class="accent-color">Getting started</p>
    </div>
  </v-flex>
  <v-container>
  <v-stepper v-model="e6" vertical class="blue-grey lighten-5">
    <v-stepper-step :complete="e6 > 1" step="1" color="pink accent-2">
      まずは皆の投稿を見てみよう！
    </v-stepper-step>

    <v-stepper-content step="1">
      <v-card dark color="grey darken-3" class="mb-2">
        <v-layout py-2 column text-xs-center>
          <v-flex xs12 sm6 text-xs-center>
            <video src="video1.mp4" type="video/mp4" controls :height="videoHeight"></video>
          </v-flex>
          <v-flex xs12 sm6 pa-3>
            <p>地図のマーカーをクリックすると皆のRespectが見られるよ</p>
            <p>※投稿をするにはサインインが必要です。</p>
          </v-flex>
        </v-layout> 
      </v-card>
      <v-btn dark color="pink accent-2" @click="e6 ++">Next</v-btn>
      <!-- <v-btn flat color="pink accent-2" @click="">Back</v-btn> -->
    </v-stepper-content>

    <v-stepper-step :complete="e6 > 2" step="2" color="pink accent-2">
      投稿をしてみよう！
    </v-stepper-step>

    <v-stepper-content step="2">
      <v-card dark color="grey darken-3" class="mb-2">
        <v-layout py-2 column text-xs-center>
          <v-flex xs12 sm6 text-xs-center>
            <video src="video2.mp4" type="video/mp4" controls :height="videoHeight"></video>
          </v-flex>
          <v-flex xs12 sm6 pa-3>
            <p>Respectしたい場所をクリック「ありがとう」か「応援」、どちらかを選ぼう。</p>
            <p>コメントを入力して（任意）一番下のマーカーボタンを押そう。</p>
            <p>※投稿をするにはサインインが必要です。</p>
          </v-flex>
        </v-layout>        
      </v-card>
      <v-btn dark color="pink accent-2" @click="e6 ++">Next</v-btn>
      <v-btn flat color="pink accent-2" @click="e6 --">Back</v-btn>
    </v-stepper-content>

    <v-stepper-step :complete="e6 > 3" step="3" color="pink accent-2">
      地図をRESPECTでいっぱいにしよう！
    </v-stepper-step>

    <v-stepper-content step="3">
      <v-card dark color="pink lighten-5" class="mb-2">
        <v-layout py-2 column text-xs-center>
          <v-flex xs12 text-xs-center>
            <v-img :src="require('../../assets/respectmap.png')" alt="RESPECT WORLD"></v-img>
          </v-flex>
        </v-layout>          
      </v-card>
      <v-btn dark color="pink accent-2" href="/">
        <v-icon>mdi-google-maps</v-icon>
        Mapを見る
      </v-btn>
      <v-btn flat color="pink accent-2" @click="e6 --">Back</v-btn>
    </v-stepper-content>
  </v-stepper>
  </v-container>
</v-layout>  
</template>

<script>
  export default {
    data: () => ({
      e6: 1
    }),

    computed: {
      videoHeight() {
        switch(this.$vuetify.breakpoint.name) {
          case 'xs': return '130'
          case 'sm': return '200'
          case 'md': return '400'
          case 'lg': return '400' 
          case 'xl': return '400'
        }
      },
    }
  }
</script>

<style scoped>
.accent-color {
  color: #424242;
}

</style>
