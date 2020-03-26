<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="12">
        <project-tree></project-tree>
      </el-col>
      <el-col :span="12">
        <role-list></role-list>
      </el-col>
    </el-row>
    <el-divider></el-divider>
    <div class="rightDetail">
      <right-details></right-details>
    </div>
    <!-- <div class="btnWrap">
      <el-button size="small">取 消</el-button>
      <el-button size="small" type="success" @click="showEmpower">快捷授权</el-button>
      <el-button size="small" type="primary">保 存</el-button>
    </div> -->

    <empower-dia ref="empower"></empower-dia>
  </div>
</template>

<script>
import ProjectTree from './projectTree'
import RoleList from './RoleListCopy'
import RightDetails from './RightsDetail'
import EmpowerDia from './Empower'
export default {
  components: { ProjectTree, RoleList, RightDetails, EmpowerDia },
  data() {
    return {
    }
  },
  methods: {
    showEmpower() {
      this.$refs.empower.show()
    }
  },
}
</script>

<style lang="css">
  .btnWrap {
    padding: 20px 0;
    text-align: right;
  }
</style>