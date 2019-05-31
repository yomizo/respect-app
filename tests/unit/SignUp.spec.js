import { shallowMount, createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import SignUp from '@/components/SignUp.vue'


const localVue = createLocalVue()

localVue.use(Vuex)

describe('SignUp', () => {
  let actions
  let store

  beforeEach(() => {
    actions = {
      submit: jest.fn(),
      signup: jest.fn()
    }
    store = new Vuex.Store({
      state: {},
      actions
    })
  })

  it('calls registerUser', () => {
    const wrapper = shallowMount(SignUp, { store, localVue })
    wrapper.find('v-btn').trigger('click')
    expect(actions.submit).toHaveBeenCalled()
  })
  

  it('is a Vue instance', () => {  
    const wrapper = shallowMount(SignUp)
    expect(wrapper.isVueInstance()).toBeTruthy()
    expect(wrapper.element).toMatchSnapshot()
  })
})