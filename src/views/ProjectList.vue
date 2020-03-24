<template>
  <div>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column label="项目名称" prop="name"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <div>
            <el-button type="text" size="mini" @click="setRight(scope.row)">配置权限</el-button>
          </div>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      tableData: [
        {name: '项目一'},
        {name: '项目二'},
        {name: '项目三'},
        {name: '项目四'},
        {name: '项目五'},
        {name: '项目六'},
        {name: '项目七'}
      ]
    }
  },
  methods: {
    setRight(row) {
      
    }
  },
}
</script>