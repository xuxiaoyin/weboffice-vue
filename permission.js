/*
 * @Author: ChasLui
 * @Date: 2020-01-08 21:17:03
 * @LastEditors: ChasLui
 * @LastEditTime: 2020-03-09 21:41:00
 * @Description: 权限控制
 */
import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress' // 进度条
import 'nprogress/nprogress.css' // 进度条样式
import { getToken } from '@/utils/auth' // 从 cookie 中获取 token
import getPageTitle from '@/utils/get-page-title'

NProgress.configure({ showSpinner: false }) // 进度条库配置

// 不重定向的白名单
const whiteList = ['/user/login', '/user/logout', '/user/registry', '/user/forget']

router.beforeEach(async(to, from, next) => {
  // 进度条开始
  NProgress.start()

  // 页面标题
  document.title = getPageTitle(to.meta.title)

  // 确定用户是否已登录
  const hasToken = getToken()

  if (hasToken) {
    if (to.path === '/user/login') {
      // 如果已登录，请重定向到主页
      next({ path: '/' })
      NProgress.done()
    } else {
      const hasGetUserInfo = store.getters.username
      if (hasGetUserInfo) {
        next()
      } else {
        try {
          // TODO 根据后台返回菜单数据生成左侧导航
          const { menus } = await store.dispatch('home/getInfo')
          // 获取用户信息
          await store.dispatch('user/getInfo')
          // 根据角色生成可访问路由映射
          const accessRoutes = await store.dispatch(
            'permission/generateRoutes',
            // roles,
            menus
          )
          // 动态添加可访问路由
          router.addRoutes(accessRoutes)
          // 设置replace: true，这样导航就不会留下历史记录
          // next({ ...to, replace: true })
          next()
        } catch (error) {
          // 删除 token 并进入登录页面重新登录
          await store.dispatch('user/resetToken')
          Message.error(error || '有一个错误')
          next(`/user/login?redirect=${to.path}`)
          NProgress.done()
        }
      }
    }
  } else {
    // 没有 token

    if (whiteList.indexOf(to.path) !== -1) {
      // 在免登录白名单中，直接进入
      next()
    } else {
      // 其他无权访问的页面将重定向到登录页面。
      next(`/user/login?redirect=${to.path}`)
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  // 进度条结束
  NProgress.done()
})
