<template>
  <v-layout row justify-center>
    <v-dialog v-model="dialog" persistent max-width="600px">
      <v-card class="opacity grey darken-4 pa-2">
        <v-card-actions>
          <v-btn
            @click="closeDialog"
            icon
            color="pink accent-2"
            flat
            >
            <v-icon>arrow_back</v-icon>
          </v-btn>
        </v-card-actions>
        <v-card-text class="headline font-weight-bold text-xs-center white--text">My Page</v-card-text>
        <v-card-text>
          <v-container grid-list-md>
            <v-layout wrap>
              <v-flex text-xs-center>
                <v-avatar class="uploadImage" @click='pickFile' size="150px" v-if="imageUrl">
                  <v-img :src="imageUrl" alt="avatar"></v-img>
                </v-avatar>
                <v-avatar class="uploadImage" @click='pickFile' size="150px" v-else>
                  <v-img :src="defaultImageName" alt="avatar"></v-img>
                </v-avatar>                                
              </v-flex>              
                <input
                  type="file"
                  name="file"
                  style="display: none"
                  ref="image"
                  accept="image/*"
                  @change="onFilePicked"
                >
              <v-flex xs12>
                <v-text-field color="pink accent-2" dark v-model="userName" label="name" required></v-text-field>
              </v-flex>
              <v-flex xs12>
                <v-text-field color="pink accent-2" dark v-model="userEmail" label="email" required></v-text-field>
              </v-flex>              
              <v-flex xs12>
                <v-text-field color="pink accent-2" dark label="NewPassword" type="password" required></v-text-field>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="pink accent-2" flat @click="editUser">Save</v-btn>
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
    imageUrl: '',
  }),

  computed: {
    dialog: {
      get() { return this.$store.getters.dialog },
      set() { this.$store.dispatch('setDialog') }
    },
    imageAddress: {
      get() { return this.$store.getters.imageAddress}
    },
    defaultImageName: function() {
      return this.imageAddress + this.imageName
    },
    userData: {
      get() { return this.$store.getters.userData}
    },
  },

  methods: {
    closeDialog() {
      this.$store.commit('updateDialog')
      this.$router.push("/")
    },

    pickFile() {
      this.$refs.image.click()
    },

    onFilePicked (e) {
      const files = e.target.files
      if(files[0] !== undefined) {
        this.imageName = files[0].name
        if(this.imageName.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader() //make instance
        fr.readAsDataURL(files[0]) // read file
        fr.addEventListener('load', () => {
          this.imageUrl = fr.result
        })
      } else {
        this.imageUrl = ''
      }
    },

    editUser(e) {
      let params = {
        name: this.userName,
        email: this.userEmail,
        image: this.imageUrl
      }
      this.$store.dispatch('editUser', ["/users/", params])
    }
  },

  created() {
    this.userName = this.userData.name
    this.userEmail = this.userData.email
    if(this.userData.image) {
      this.imageUrl = this.userData.image
    }
  },
}
</script>

<style>
.uploadImage {
  cursor: pointer;
}
</style>

