import { mount } from '@vue/test-utils'
import SignUp from './components/SignUp'

describe('SignUp', () => {
  const wrapper = mount(SignUp)

  it('is a Vue instance', () => {  
    expect(wrapper.isVueInstance()).toBeTruthy()
    expect(wrapper.element).toMatchSnapshot()
  })
})