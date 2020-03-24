<template>
  <div>
    <el-checkbox-group v-model="checkList">
      <el-checkbox v-for="item in rightsList" :key="item" :label="item" border size="small" class="item">{{item}}</el-checkbox>
    </el-checkbox-group>
  </div>
</template>

<script>
export default {
  data() {
    return {
      rightsList: ['只读', '项目编辑', '项目删除(终止)', '项目参与人修改', '目录编辑', '文件在线编辑', '文件删除'],
      checkList: []
    }
  }
}
</script>