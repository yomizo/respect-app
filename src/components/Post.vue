<template>
  <v-dialog
    v-model="dialog"
    max-width="290"
    persistent
  >
    <v-card class="opacity grey darken-4 pa-2">
      <v-card-actions>
        <v-btn @click="isCancel" 
          icon 
          color="pink accent-2"
          flat
          small>
          <v-icon>arrow_back</v-icon>
        </v-btn>
        <v-spacer></v-spacer>          
      </v-card-actions>
      <v-card-text class="title text-xs-center white--text">
        RESPECTしますか？
      </v-card-text>

      <v-card-text class="text-xs-center">
        <v-btn v-for="(message, i) in messages" 
          fab
          :key="i"
          :depressed="message.toggle"
          :large="message.toggle"
          :dissabled="message.toggle"
          color="pink lighten-5"
          @click="toggle(message)"
          >
          <v-avatar size="48">
            <img :src="message.src" alt="avatar">
          </v-avatar>
        </v-btn>
      </v-card-text>
      <v-textarea v-model="comment"
        label="Comment"
        outline
        auto-grow
        counter=140
        color="pink lighten-5"
        dark
        ></v-textarea>
      <v-card-text class="text-xs-center">
        <v-btn
          round
          dark
          fab
          color="pink accent-2"
          @click="isOk"
        >
          <v-icon>add_location</v-icon>
        </v-btn>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  data () {
    return {
      messages: [
        {
          name: "Thanks!",
          src: "thanks_55.png",
          toggle: false
        },          
        {
          name: "Fight!",
          src: "cheer_55.png",
          toggle: false,
        },          
      ],
      comment: '',
    }
  },

  computed: {
    // defined vuex(store) variable
    dialog: {
      get() { return this.$store.getters.dialog },
      set() { this.$store.dispatch('setDialog') }
    },
    marker: {
      get() { return this.$store.getters.marker },
    },
    map: {
      get() { return this.$store.getters.map }
    },
    token: {
      get() { return this.$store.getters.token }
    },
    searchList: {
      get() { return this.$store.getters.searchList }
    },      
  },

  methods: {
    closeDialog() {
      this.$store.dispatch('setDialog')
      this.comment = ''
    },
    //vuex state.dialog update & add_marker
    isOk() {
      self = this
      let isDelete = true // just default
      // add_marker and delete tmpMarker
      this.messages.forEach((message, i) => {
        if (message.toggle) {
          let respect = i // respect is 0 or 1
          this.marker.setIcon(this.messages[i].src)
          this.marker.addListener('click', function(e){
            // get latlng data
            let latLng = e.latLng
            // search postData using latlng in searchList
            let postData = self.searchList.filter(function(item, i){
              let storedLatLng = new google.maps.LatLng(item.lat, item.lng, false)
              if (storedLatLng.equals(latLng)) return true
            })
            self.$store.dispatch('setPostData', "/posts/" + postData[0].id)
          })
          // create record in DB
          this.createPost(respect)
          isDelete = false // marker isn't deleted
        }
        this.messages[i].toggle = false
      })
      // "setMap(null)" is delete marker
      if (isDelete) { this.marker.setMap(null)}
      this.closeDialog()
    },
    // push cancel btn
    isCancel() {
      this.marker.setMap(null)
      this.closeDialog()
      this.messages.forEach((msg,i) =>{
        this.messages[i].toggle = false
      })
    },
    // set this.messages[0~1].toggle
    toggle(msg){
      this.messages.forEach( (message, i) => {
        if (message.name == msg.name ) {
          this.messages[i].toggle = true
        } else {
          this.messages[i].toggle = false
        }
      })
    },

    createPost(respect) {
      let params = {
        respect: respect,
        lat: this.marker.getPosition().lat(),
        lng: this.marker.getPosition().lng(),
        comment: this.comment,
      }
      this.$store.dispatch('createPost', ['/posts', params])
    },
  },
}
</script>

<style>
.opacity {
  opacity: 0.9;
}
</style>

