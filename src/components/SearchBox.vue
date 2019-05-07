<template>
  <v-dialog
    v-model="dialog"
    max-width="600">
    <!-- <v-container> -->
      <v-text-field
        v-model="searchWord"
        hide-details
        color="pink accent-4"
        class="grey darken-4"
        dark
        outline
        clearable
        append-icon="search"
        @click:append="searchLocation"
        >
      </v-text-field>
    <!-- </v-container> -->
  </v-dialog>
</template>

<script>
export default {
  data() {
    return {
      searchWord: "",
      dialog: true,
    }
  },
  computed: {
    map: {
      get() { return this.$store.getters.map }
    },
    // dialog: {
    //   get() { return this.$store.getters.dialog},
    //   set() { this.$store.commit('setDialog')}
    // }
  },
  methods: {
    // search function with google
    searchLocation() {
      let request = {
        query: this.searchWord,
        fields: [ 'name', 'geometry']
      }
      let service = new google.maps.places.PlacesService(this.map)
      let vm = this
      // query search
      service.findPlaceFromQuery( request, function(results, status) {
        if ( status === google.maps.places.PlacesServiceStatus.OK ) {
          vm.map.setCenter( results[0].geometry.location)
        } else {
          vm.$store.commit("updateFlash", "NOT FOUND")
          vm.$store.commit("updateIsSnackBar")
        }
      })
      // // nearby search
      // request = {
      //   location: this.map.getCenter(),
      //   radius: '500',
      //   type: [this.searchWord]
      // }
      // service.textSearch( request, function(results, status) {
      //   if ( status === google.maps.places.PlacesServiceStatus.OK) {
      //     for (let i = 0; i < results.length; i++) {
      //       let place = results[i];
      //       createMarker(results[i]);
      //     }
      //   }
      // })
    }
  }
}
</script>

<style>
.searchBox {
  max-width: 760px;
  opacity: 0.9;
}
</style>

