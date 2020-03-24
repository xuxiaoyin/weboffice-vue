<template>
  <el-card class="copyRights">
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card shadow="never" class="projectList listWrap">
          <div slot="header">
            选择需要授权的项目
            <el-button size="small" @click="showEmpower" style="float: right; padding: 3px 0" type="text">快捷授权</el-button>
          </div>
          <el-radio-group v-model="project" @change="selectProject">
            <div v-for="item in projectList" :key="item.id" class="list">
              <el-radio :label="item.id">{{item.label}}</el-radio>
            </div>
          </el-radio-group>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="never" class="listWrap">
          <div slot="header">
            选择需要授权的角色
            <el-button size="small" style="float: right; padding: 3px 0" type="text">新增角色</el-button>
          </div>
          <role-list :checkList="checkList"></role-list>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="never" class="listWrap">
          <div slot="header">
            权限树
          </div>
          <rights-tree></rights-tree>
        </el-card>
      </el-col>
    </el-row>
    <el-divider></el-divider>
    <div class="btnWrap">
      <el-button size="small">取 消</el-button>
      <el-button size="small" type="primary">保 存</el-button>
    </div>

    <empower-dia ref="empower"></empower-dia>
  </el-card>
</template>

<script>
import RightsTree from './components/RightsTree'
import RoleList from './components/RoleList'
import EmpowerDia from './components/Empower'
export default {
  components: { RightsTree, RoleList, EmpowerDia },
  data() {
    return {
      projectList: [
        {id: 1, label: '项目1', role: [1, 2]},
        {id: 2, label: '项目2', role: [5, 3]},
        {id: 3, label: '项目3', role: [1, 4]},
        {id: 4, label: '项目4', role: [3, 4]},
        {id: 5, label: '项目5', role: [1, 5, 6]},
        {id: 6, label: '项目6', role: [2, 3, 6]},
      ],
      project: '',
      checkList: []
    }
  },
  methods: {
    showEmpower() {
      this.$refs.empower.show()
    },
    selectProject(val) {
      const arr = this.projectList.filter(item => item.id === val)
      this.checkList = arr[0].role
    }
  },
}
</script>

<style lang="css">
  .btnWrap {
    text-align: right;
  }
  .projectList .list {
    line-height: 32px;
  }
  .copyRights .listWrap {
    height: 430px;
    overflow: auto;
  }
</style>