<template>
  <div class="roleList">
    <!-- <el-checkbox-group v-model="checkList"> -->
      <el-radio-group v-model="radio" @change="roleChange">
        <div class="list" v-for="item in roleList" :key="item.id">
          <el-radio :label="item.id">
            {{item.label}}
            <img src="../../assets/checked.png" style="width: 16px;" v-if="checkList.includes(item.id)"/>
            <!-- <el-checkbox :label="item.id" border size="small" class="item" disabled>{{item.label}}</el-checkbox> -->
          </el-radio>
        </div>
      </el-radio-group>
    <!-- </el-checkbox-group> -->
  </div>
</template>

<script>
export default {
  props: { checkList: Array },
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
      rightList: []
    }
  },
  methods: {
    roleChange(val) {
      console.log(val)
      console.log(this.$parent)
      this.$parent.$emit('roleChange', val, this.checkList.includes(val))
    }
  },
}
</script>

<style lang="css">
.roleList .list {
  display: inline-block;
  width: 160px;
  line-height: 32px;
}
.roleList .item{
  margin-left: 0 !important;
}
</style>