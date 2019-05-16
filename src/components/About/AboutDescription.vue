<template>
<v-layout id="description" column py-5 class="grey darken-3">
  <v-flex class="display-2 font-weight-medium text-xs-center">
    <div data-aos="fade-up">
      <p class="accent-color">RESPECTSとは？</p>
    </div>
  </v-flex>
  <v-card flat class="grey darken-3">
    <v-window v-model="onboarding" touch>
      <v-window-item>
        <v-container>
        <v-layout :column="isColumn">
          <v-flex xs12 sm6 text-xs-center>
            <img :src="require('../../assets/problem.png')" alt="悩み" :height="imageHeight">
          </v-flex>
          <v-flex xs12 sm6 class="white--text">
            <v-container>
              <h2>私の悩み</h2>
              <div>
                <p>
                  世の中、語気の強い意見や批判ばかりが拡散されていて目立つけれど、
                  「こんな世の中でいいの？」<br>
                  <ul>
                    <li>接客業の店員さんの細かなミスを指摘し、行き過ぎたクレームを繰り返す人。</li>
                    <li>自分に何の不利益もないのに、誰かの失敗をこれでもかと叩く人。</li>
                  </ul>
                  皆そういう人を恐れてルールをガチガチに縛り始めます。
                  そのせいで「なんか窮屈だなぁ。」
                  と感じる事もしばしば。一部のクレーマーや心の狭い人のせいで、みんなが生きにくくなっていないかな？
                  でも、自分に出来る事って何だろう？<br>
                  うーん...
                </p>
              </div>
            </v-container>
          </v-flex>
        </v-layout>
        </v-container>
      </v-window-item>
      <v-window-item>
        <v-container>
        <v-layout :column="isColumn">
          <v-flex xs12 sm6 text-xs-center>
            <img :src="require('../../assets/solution.png')" alt="解決法" :height="imageHeight">
          </v-flex>
          <v-flex xs12 sm6 class="white--text">
            <v-container>
              <h2>逆に感謝してる人の方が多くない？</h2>
              <p>
                そうだ！丁寧な接客を受けて感謝したい時や
                大変そうに働いている人を見て、応援したい時ってあるよな。
                こういう人ってクレーム言う人より多いかも。<br>
                そういう人たちの気持ちを可視化するにはどうしたらいいだろう？<br>
              </p>
              <p>
                <ul>
                  <li>スマホかなんかで簡単に</li>
                  <li>いつでも</li>
                </ul>
                そういうアプリってあったらいいかもな。<br>
                そこで考えてみた...
              </p>
            </v-container>
          </v-flex>
        </v-layout>
        </v-container>
      </v-window-item>
      <v-window-item>
        <v-container>
        <v-layout :column="isColumn">
          <v-flex xs12 sm6 text-xs-center>
            <img :src="require('../../assets/respects.png')" alt="地図に感謝を" :height="imageHeight">
          </v-flex>
          <v-flex xs12 sm6 class="white--text">
            <v-container>
              <h2>地図にRESPECTを</h2>
              <p>
                <ul>
                  <li>知らない誰かに感謝したい時</li>
                  <li>知らない誰かを応援したい時</li>
                </ul>
                そんな時はこのアプリをつかって地図にRESPECT（感謝と応援）を示そう！<br>
                と、こんな経緯でこのアプリは生まれました。是非地図をRESPECTでいっぱいにしてみて下さい。<br>
                そしていずれは...
              </p>
            </v-container>
          </v-flex>
        </v-layout>
        </v-container>
      </v-window-item>      
    </v-window>
    <v-card-actions class="justify-space-between">
      <v-btn flat @click="prev" color="pink accent-2">
        <v-icon>mdi-chevron-left</v-icon>
      </v-btn>
      <v-item-group
        v-model="onboarding"
        class="text-xs-center"
        mandatory
        >
        <v-item
          v-for="n in length"
          :key="`btn-${n}`">
          <v-btn
            slot-scope="{ active, toggle }"
            :input-value="active"
            icon
            dark
            @click="toggle">
            <v-icon color="pink accent-2">mdi-record</v-icon>
          </v-btn>
        </v-item>
      </v-item-group>
      <v-btn
      flat
      color="pink accent-2"
      @click="next">
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
    </v-card-actions>
  </v-card>
</v-layout>
</template>

<script>
export default {
  data:() => ({
    length: 3,
    onboarding: 0,
  }),

  computed: {
    imageHeight () {
      switch(this.$vuetify.breakpoint.name) {
        case 'xs': return '120px'
        case 'sm': return '250px'
        case 'md': return '400px'
      }
    },
    isColumn() {
      if(this.$vuetify.breakpoint.xsOnly) { return true}
    }
  },

  //
  methods: {
    next() {
      this.onboarding = this.onboarding + 1 === this.length 
      ? 0
      :this.onboarding + 1
    },
    prev() {
      this.onboarding = this.onboarding - 1 < 0
      ? this.length - 1
      :this.onboarding - 1
    },    
  }
}
</script>
<style>
.v-card{
  min-width: 90vw;
  max-height: 100vh;
}

p {
  line-height: 28px;
}

h2 {
  margin-bottom: 10px;
}

#description {
  min-height: 100vh;
}

.accent-color {
  text-shadow: 1px 1px 1px #424242;
  color: #ff4081;
}
</style>
