<template>
  <div id="app">
    <div id="nav">
      <router-link to="/projectList">项目列表</router-link> |
      <router-link to="/">文件列表</router-link> |
      <!-- <router-link to="/about">About</router-link> | -->
      <!-- <router-link to="/office">Office</router-link> | -->
      <router-link to="/fullcalendar">日历</router-link> |
      <router-link to="/rights">权限</router-link> |
      <router-link to="/rightsCopy">权限重构</router-link>
    </div>
    <router-view/>
  </div>
</template>

<style>
html, body {
  margin: 0;
  padding: 0;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  padding: 20px;
}

#nav {
  padding: 20px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
