<template>
  <div id="map"></div>
</template>


<script>
export default {
  data(){
    return {
      map: null,
      markers: [],
      iconBase: 'https://developers.google.com/maps/documentation/javascript/examples/full/images/',
      center: {lat: -25.363,lng: 131.044},
      zoom: 6,
      icons: {
        cheer: 'fight55.png',
        thanks: 'heart55.png',
      },
    }
  },


  computed: {
    marker: {
      get() { return this.$store.getters.marker }
    },
    markerList: {
      get() { return this.$store.getters.markerList }
    },
    token: {
      get() { return this.$store.getters.token }
    }
  },
  
  
  methods:{
    //vuex state.dialog update
    raiseDialog(tempMarker, map) {
      this.$store.dispatch('setDialog')
      this.$store.dispatch('setMarker', [tempMarker, map])
    },
    isToken() {
      if(!this.token) {
        this.$store.commit('updateFlash', "If you mark the map, Please Signin")
        this.$store.commit('updateIsSnackBar')
        this.$store.commit('updateSnackBarColor', {color: "pink accent-3"})
        return true
      }
    },

    culPosition: function(lat, lng) {
      return new google.maps.LatLng(lat, lng)
    },

    makeMarker: function(latLng, map) {
      // signin?
      if (this.isToken()) {
        return
      }
      // make TEMP marker
      let tempMarker = new google.maps.Marker({
        position: latLng,
        map: map,
      })

      map.panTo(latLng) // move center to clicked place
      map.panBy(0, 170) // offset below
      
      this.raiseDialog(tempMarker, map) // raise modal
    },

    
  },
  
  //Life cycle
  beforeCreate(){
    // set posts_json
    this.$store.dispatch('markerList', ['/posts'])
  },  

  mounted(){
    //initMap
    this.map = new google.maps.Map(document.getElementById('map'),{
      center: this.center,
      zoom: this.zoom
    })  

    //map click event listen
    let vm = this
    this.map.addListener('click', function(e){
      vm.makeMarker(e.latLng, vm.map) //will change that popup modal
    })
  },


  watch: {
    // After markerList is fill, allocate initial markers
    markerList: function(newVal, oldVal) {
      let vm = this
      if(newVal){
        newVal.forEach(function(post) {
          var marker = new google.maps.Marker({
            position: {lat: post.lat, lng: post.lng},
            icon: vm.icons[post.respect],
            map: vm.map
          })
          // show postData when marker clicked
          marker.addListener('click', function(e){
            // get latlng data
            let latLng = e.latLng
            // marker postData using latlng in markerList
            let postData = newVal.filter(function(item, i){
              let storedLatLng = new google.maps.LatLng(item.lat, item.lng, false)
              if (storedLatLng.equals(latLng)) return true
            })
            vm.$store.dispatch('setPostData', postData[0])
            vm.$store.dispatch('setDialog')
            vm.$router.push('/postshow') //redirect
          })          
        })
      }
    },

    // authentication
    token: function(newToken) {
      if(!newToken) {
        this.$router.push('/')
      }
    }
  }
}
</script>


<style>
#map {
  height: auto;
  min-height: 100vh;
}
</style>

