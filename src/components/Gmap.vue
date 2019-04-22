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
      zoom: 8,
      features:  [
        {
          position: this.culPosition(-25.365, 131.340),
          type: 'info'
        },
        {
          position: this.culPosition(-25.560, 131.030),
          type: 'parking'
        },        
      ],
      icons: {
        parking: {
          name: 'Parking',
          icon: 'fight55.png'
        },
        info: {
          name: 'Info',
          icon: 'heart55.png'
        },        
      },
    }
  },
  methods:{
    //vuex state.dialog update
    raiseDialog(tempMarker) {
      this.$store.dispatch('setDialog', [tempMarker, map])
    },

    culPosition: function(lat, lng) {
      return new google.maps.LatLng(lat, lng)
    },

    makeMarker: function(latLng, map) {
      // make TEMP marker
      var tempMarker = new google.maps.Marker({
        position: latLng,
        map: map,
      })

      map.panTo(latLng) // move center to clicked place
      map.panBy(0, 150) // offset below
      
      this.raiseDialog(tempMarker, map) // raise modal
      
      // marker.addListener('click', function(e){
      //   console.log("addmarker clicked")
      // })
    },

    
  },
  computed: {
    dialog: {
      get() { return this.$store.getters.dialog },
      // set() { this.$store.dispatch('doUpdate') }
    },
    marker: {
      get() { return this.$store.getters.marker },
    },
    search_list: {
      get() { return this.$store.getters.search_list },
    },    
  },
  
  //Life cycle
  created(){
    // get posts_json
    this.$store.dispatch('setPosts', ['/posts'])
  },  
  mounted(){
    //initMap
    this.map = new google.maps.Map(document.getElementById('map'),{
      center: this.center,
      zoom: this.zoom
    })

    // make marker gio 
    for (var i = 0; i < this.features.length; i++) {
      var marker = new google.maps.Marker({
        position: this.features[i].position,
        icon: this.icons[this.features[i].type].icon,
        map: this.map
      })
      // marker click event listen
      marker.addListener('click', function(e){
        console.log("marker clicked")
      })
    }

    //map click event listen
    var self = this
    this.map.addListener('click', function(e){
      self.makeMarker(e.latLng, self.map) //will change that popup modal
    })
  },
}
</script>


<style>
#map {
  margin-top: 40px;
  height: auto;
  min-height: 95vh;
}
</style>

