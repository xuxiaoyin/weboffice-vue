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
      rightsList: ['查看权限', '编辑权限', '删除(终止)权限', '操作人员权限'],
      checkList: []
    }
  }
}
</script>