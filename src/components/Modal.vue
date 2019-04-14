<template>
  <v-layout row justify-center >
    <v-dialog
      v-model="dialog"
      max-width="290"
      persistent
    >
      <v-card class="tp blue-grey lighten-5">
        <v-card-title class="title">ここにRESPECTしますか？</v-card-title>

        <v-card-text class="text-xs-center">
          <v-btn v-for="message in messages" 
            fab 
            @click="toggle(message)"
            >
            <v-avatar size="48">
              <img :src="message.src" alt="avatar">
            </v-avatar>
          </v-btn>
        </v-card-text>
        <div class="text-xs-center">
          <v-btn
            round
            dark
            color="orange darken-1"
            @click="doUpdate"
          >
            Cancel
          </v-btn>
          <v-btn
            round
            dark
            color="orange darken-1"
            @click="doUpdate"
          >
            OK!
          </v-btn>
        </div>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
  export default {
    data () {
      return {
        messages: [
          {
            name: "Fight!",
            src: "fight55.png",
            toggle: false,
          },
          {
            name: "Thanks!",
            src: "heart55.png",
            toggle: false
          }          
        ]
      }
    },
    methods: {
      //vuex state.dialog update
      doUpdate(message) {
        // this.marker.setMap(null) // delete tmp marker
        // console.log(this.map)
        // this.marker.icon = 'fight55.png'
        if (this.messages[0].toggle) {
          this.marker.setIcon(this.messages[0].src)
          this.messages[0].toggle = false
        } else if (this.messages[1].toggle) {
          this.marker.setIcon(this.messages[1].src)
          this.messages[1].toggle = false
        } else {
          this.marker.setMap(null)
        }
        this.$store.dispatch('doUpdate', [null, null])
      },
      toggle(message){
        if(message.name == "Fight!"){
          this.messages[0].toggle = !this.messages[0].toggle
          if(this.messages[0].toggle){this.messages[1].toggle = false}
        } else {
          this.messages[1].toggle = !this.messages[1].toggle
          if(this.messages[1].toggle){this.messages[0].toggle = false}
        }
      }
    },
    computed: {
      dialog: {
        get() { return this.$store.getters.dialog },
        set() { this.$store.dispatch('doupdate', null) }
      },
      marker: {
        get() { return this.$store.getters.marker },
        // set() { this.$store.dispatch('doupdate', null) }
      },
      map: {
        get() { return this.$store.getters.map }
      }
    }
  
  }
</script>

<style>
.tp {
  opacity: 0.94;
}
</style>

