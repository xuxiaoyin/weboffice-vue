<template>
  <div class="roleList">
    <el-checkbox-group v-model="checkList">
      <el-radio-group v-model="radio" @change="roleChange">
        <div class="list" v-for="item in roleList" :key="item.id">
          <el-radio :label="item.id">
            <!-- <img src="../../assets/checked.png" style="width: 16px;" v-if="checkList.includes(item.id)"/> -->
            <el-checkbox :label="item.id" border size="small" class="item">{{item.label}}</el-checkbox>
          </el-radio>
        </div>
      </el-radio-group>
    </el-checkbox-group>
  </div>
</template>

<script>
export default {
  data() {
    return {
      radio: '',
      roleList: [
        {id: 1, label: '管理员', right: []},
        {id: 2, label: '项目组成员'},
        {id: 3, label: '项目负责人'},
        {id: 4, label: '质控'},
        {id: 5, label: '风控'},
        {id: 6, label: '委员会'},
        {id: 7, label: '运营'},
        {id: 8, label: '监管'},
        {id: 9, label: '角色A'},
        {id: 10, label: '角色B'},
      ],
      rightList: [],
      checkList: []
    }
  },
  methods: {
    roleChange(val) {
      this.$emit('roleChange')
      console.log(val)
    }
  },
}
</script>

<style lang="css">
.roleList .list {
  display: inline-block;
  width: 160px;
  margin-bottom: 20px;
}
.roleList .item{
  margin-left: 0 !important;
}
</style>