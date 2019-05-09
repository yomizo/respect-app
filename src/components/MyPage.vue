<template>
  <v-layout row justify-center>
    <v-dialog v-model="dialog" persistent max-width="600px">
      <v-card>
        <v-card-title>
          <span class="headline">My Page</span>
        </v-card-title>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex text-xs-center>
                <v-avatar size="150px" v-if="imageUrl">
                  <v-img :src="imageUrl" alt="avatar"></v-img>
                </v-avatar>
                <v-avatar size="150px" v-else>
                  <v-img :src="imageAddressName" alt="avatar"></v-img>
                </v-avatar>                
              </v-flex>
              <v-flex xs12 class="text-xs-center text-sm-center text-md-center text-lg-center">
                <v-text-field label="Select Image" @click='pickFile' v-model='imageName' prepend-icon='attach_file'></v-text-field>
                <input
                  type="file"
                  name="file"
                  style="display: none"
                  ref="image"
                  accept="image/*"
                  @change="onFilePicked"
                >
              </v-flex>              
              <v-flex xs12>
                <v-text-field v-model="userName" label="name" required></v-text-field>
              </v-flex>
              <v-flex xs12>
                <v-text-field v-model="userEmail" label="email" required></v-text-field>
              </v-flex>              
              <v-flex xs12>
                <v-text-field label="NewPassword" type="password" required></v-text-field>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" flat @click="closeDialog">Close</v-btn>
          <v-btn color="blue darken-1" flat @click="editUser">Save</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
export default {
  data:() => ({
    userName: "default",
    userEmail: "default@gmail.com",
    imageName: "default_icon.png",

    //
    imageUrl: '',
    imageFile: ''
  }),

  //
  computed: {
    dialog: {
      get() { return this.$store.getters.dialog },
      set() { this.$store.dispatch('setDialog') }
    },
    imageAddress: {
      get() { return this.$store.getters.imageAddress}
    },
    imageAddressName: function() {
      return this.imageAddress + this.imageName
    },
    userData: {
      get() { return this.$store.getters.userData}
    },
  },

  //
  methods: {
    closeDialog() {
      this.$store.commit('updateDialog')
      this.$router.push("/")
    },

    //
    pickFile() {
      this.$refs.image.click()
    },

    //
    onFilePicked (e) {
      const files = e.target.files
      if(files[0] !== undefined) {
        this.imageName = files[0].name
        if(this.imageName.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(files[0])
        fr.addEventListener('load', () => {
          this.imageUrl = fr.result
          this.imageFile = files[0]
        })
      } else {
        this.imageFile = ''
        this.imageUrl = ''
      }
    },

    //
    editUser(e) {
      // let params = new FormData()
      // let fileSelectDom = $('[name=\`file\`]')[0]
      // let files = e.target.files

      // params.append('name', this.userName)
      // params.append('email', this.userEmail)      
      // params.append('image_name', this.imageName)
      // params.append('image', this.imageFile)
      let params = {
        name: this.userName,
        email: this.userEmail,
        image_name: this.imageName,
        image: this.imageFile
      }
      this.$store.dispatch('editUser', ["/users/", params])
    }
  },

  //
  created() {
    this.userName = this.userData.name
    this.userEmail = this.userData.email
    if(this.userData.image_name) {
      this.imageName = this.userData.image_name
    }
  },
}
</script>

