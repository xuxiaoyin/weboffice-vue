import 'babel-polyfill'
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import Base64 from './common/js/base64.js'

Vue.config.productionTip = false
Vue.use(ElementUI);
Vue.prototype.$Base64 = Base64;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
