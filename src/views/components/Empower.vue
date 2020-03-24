<template>
  <el-dialog title="快捷授权" :visible.sync="dialogVisible" width="640px" class="power">
    <div class="tips">
      提示：此操作适用于批量对项目中已审核文件的只读权限进行快速授权。
    </div>
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card shadow="never">
          <div slot="header">项目列表:</div>
          <el-checkbox-group v-model="selectProject">
            <div class="item" v-for="item in projectList" :key="item.id" >
              <el-checkbox :label="item.id" size="small" class="item">{{item.label}}</el-checkbox>
            </div>
          </el-checkbox-group>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="never">
          <div slot="header">角色列表:</div>
          <el-checkbox-group v-model="selectRole">
            <div class="item" v-for="item in roleList" :key="item.id" >
              <el-checkbox :label="item.id" size="small" class="item">{{item.label}}</el-checkbox>
            </div>
          </el-checkbox-group>
        </el-card>
      </el-col>
    </el-row>
    <span slot="footer" class="dialog-footer">
      <el-button @click="dialogVisible = false" size="small">取 消</el-button>
      <el-button type="primary" @click="dialogVisible = false" size="small">确 定</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialogVisible: false,
      projectList: [
        {id: 1, label: '项目1'},
        {id: 2, label: '项目2'},
        {id: 3, label: '项目3'},
        {id: 4, label: '项目4'},
        {id: 5, label: '项目5'},
        {id: 6, label: '项目6'},
      ],
      roleList: [
        {id: 1, label: '角色1'},
        {id: 2, label: '角色2'},
        {id: 3, label: '角色3'},
        {id: 4, label: '角色4'},
        {id: 5, label: '角色5'},
        {id: 6, label: '角色6'},
      ],
      selectProject: [],
      selectRole: []
    }
  },
  methods: {
    show() {
      this.dialogVisible = true
    }
  },
}
</script>

<style lang="css">
  .power .el-card__header {
    padding: 10px 20px;
  }
</style>

<style lang="css" scoped>
  .tips {
    position: absolute;
    top: 60px;
    color: #ff7f83;
  }
  .item {
    margin-bottom: 4px;
  }
</style>