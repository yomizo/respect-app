<template>
  <v-content class="grey darken-3">
    <v-container class="formx">
      <v-card>
        <v-container>
          <div class="headline font-weight-bold">SignUp</div>
          <form>
            <v-text-field
              v-model="name"
              v-validate="'required|max:10'"
              :counter="10"
              :error-messages="errors.collect('name')"
              label="Name"
              data-vv-name="name"
              required
            ></v-text-field>
            <v-text-field
              v-model="email"
              v-validate="'required|email'"
              :error-messages="errors.collect('email')"
              label="E-mail"
              data-vv-name="email"
              required
            ></v-text-field>
            <v-text-field 
              v-model="password"
              v-validate="'required'" 
              name="password" 
              type="password" 
              :class="{'is-danger': errors.has('password')}" 
              placeholder="Password" 
              ref="password"></v-text-field>
            <div class="text-xs-right">
              <v-btn @click="submit">submit</v-btn>
              <v-btn @click="clear">clear</v-btn>
            </div>
          </form>
        </v-container>
      </v-card>
    </v-container>
  </v-content>
</template>

<script>
  import Vue from 'vue'
  import VeeValidate from 'vee-validate'

  Vue.use(VeeValidate)

  export default {
    $_veeValidate: {
      validator: 'new'
    },

    data: () => ({
      name: '',
      email: '',
      password: '',
      // flash_message_dic
      dictionary: {
        attributes: {
          email: 'E-mail Address'
        },
        custom: {
          name: {
            required: () => 'Name can not be empty',
            max: 'The name field may not be greater than 10 characters'
            // custom messages
          },
          select: {
            required: 'Select field is required'
          }
        }
      }
    }),

    mounted () {
      this.$validator.localize('en', this.dictionary)
    },

    methods: {
      submit () {
        var judge
        this.$validator.validateAll().then((result) => {
          if(!result) {
            alert(this.errors.all())
            return
          }
          this.registerUser()
        })
      },
      clear () {
        this.name = ''
        this.email = ''
        this.password = ''
        this.$validator.reset()
      },
      registerUser() {
        var params = {
          name: this.name, 
          email: this.email, 
          password: this.password
          }
        this.$store.dispatch('registerUser', ['/users', params])
      }
    }
  }
</script>

<style>
.formx {
  max-width: 768px
}
</style>
