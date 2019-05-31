<template>
<transition>
  <v-layout
    v-if="show"
    key="before"
    id="before"
    class="section pink lighten-5">
    <v-avatar
      v-for="(image, i) in thanksImages"
      :key="`thanks-${i}`"
      size="128px"
      style="position: absolute"
      :style="{top: image.top, left: image.left}"
      data-aos="fade-down" :data-aos-delay="image.delay"
      >
      <v-img :src="require('../../assets/thanks_gig.png')"></v-img>
    </v-avatar>
    <v-avatar
      v-for="(image, i) in cheerImages"
      :key="`cheer-${i}`"
      size="128px"
      style="position: absolute"
      :style="{top: image.top, left: image.left}"
      data-aos="fade-down" :data-aos-delay="image.delay"
      >
      <v-img :src="require('../../assets/fight_gig.png')"></v-img>
    </v-avatar>
  </v-layout>
  <v-layout
    v-else
    key="after"
    id="after"
    class="section pink lighten-5"
    align-center
    justify-center>    
    <div>
      <h1 class="display-3 white--text font-weight-bold"
        data-aos="fade" data-aos-delay="400">
        FLOOD
      </h1>
      <h1 class="display-3 white--text font-weight-bold"
        data-aos="fade" data-aos-delay="600">
        RESPECTS!
      </h1>
    </div>      
  </v-layout>
</transition>  
</template>

<script>
export default {
  data: () => ({
    show: true,
    thanksImages: [
      { top: "50%", left: "50%", delay: "200"},
      { top: "35%", left: "30%", delay: "300"},
      { top: "55%", left: "30%", delay: "400"},
      { top: "30%", left: "60%", delay: "500"},
      { top: "50%", left: "25%", delay: "600"},
      { top: "55%", left: "40%", delay: "600"},
      { top: "25%", left: "50%", delay: "700"},      
    ],
    cheerImages: [
      { top: "60%", left: "60%", delay: "200"},
      { top: "25%", left: "15%", delay: "300"},
      { top: "55%", left: "20%", delay: "400"},
      { top: "30%", left: "80%", delay: "500"},
      { top: "25%", left: "75%", delay: "600"},
      { top: "35%", left: "50%", delay: "700"},
      { top: "50%", left: "45%", delay: "800"},      
    ],    
  }),

  methods: {
    isShow() {
      this.show = !this.show
    }
  },
  
  mounted() {
    setTimeout(this.isShow, 2000)
  }
}
</script>

<style>
.section {
  min-height: 100vh;
}
/* transision */
.v-enter-active, .v-leave-active {
  transition: opacity 1s;
}

.v-leave-active {
  position: absolute;
}

.v-enter, .v-leave-to {
  opacity: 0;
}

#before {
  background: url("../../assets/worldmap.png") center no-repeat;
  background-position: center;
  position: relative;
}

#after {
  background: url("../../assets/respectmap.png") center no-repeat;
  background-position: center;
}
/* typograph */
h1 {
  text-shadow: 1px 2px 3px #424242
}
</style>

