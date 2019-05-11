<template>
<div>
  <v-tooltip left>
    <template v-slot:activator="{on}">
      <v-btn
        v-on="on"
        @click="raiseSearchBox"
        class="searchBtn"
        dark
        fab
        bottom
        right
        fixed
        color="pink accent-2"
        to="/searchbox"
        >
        <v-icon>mdi-map-search</v-icon>
      </v-btn>
    </template>
    <span>SEARCH</span>
  </v-tooltip>
  <v-tooltip left>
    <template v-slot:activator="{on}">
      <v-btn
        v-on="on"
        @click="movePosition"
        class="current"
        dark
        fab
        bottom
        right
        fixed
        color="pink accent-2"
        >
        <v-icon>mdi-near-me</v-icon>
      </v-btn>
    </template>
    <span>現在地を取得</span>
  </v-tooltip>
</div>
</template>

<script>
export default {
  data() {
    return {
      center: {lat: 35.681236, lng: 139.767125}
    }
  },

  //
  computed: {
    map: {
      get() { return this.$store.getters.map }
    },
    // dialog: {
    //   get() { return this.$store.getters.dialog },
    //   set() { this.$store.dispatch('setDialog') }
    // },    
  },

  //
  methods: {
    // 現在位置に移動
    movePosition() {
      this.map.setCenter(this.center)
      this.$store.dispatch('markerList', ['/posts', this.center])
    },

    //
    raiseSearchBox() {
      this.$store.dispatch('setDialog')

    }
  },

  // lifecycle
  beforeCreate() {
    // ユーザーの現在地の取得
    let vm = this
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        let pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        vm.center = pos
      }, function(error) {
          alert(error)
        })
    } else {
      alert("Can't get your position")
    }        
  }

}
</script>

<style>
.searchBtn {
  margin-bottom: 110px;
}
.current {
  margin-bottom: 40px;
}
</style>
