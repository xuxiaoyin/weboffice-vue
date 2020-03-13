 <template>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="name" label="文件名"> </el-table-column>
      <el-table-column align="center" width="100">
        <template slot-scope="scope">
          <el-button type="text" size="mini" @click="eiteOnline(scope.row)">在线编辑</el-button>
        </template>
      </el-table-column>
    </el-table>
  </template>

  <script>
    export default {
      data() {
        return {
          tableData: [
            { name: '模板一.doc', url: 'E:/项目/全栈/weboffice/src/assets/plugins/html/Document/模板一.doc'},
            { name: '模板二.doc', url: 'E:/项目/全栈/weboffice/src/assets/plugins/html/Document/模板二.doc'},
            { name: 'sample.pdf', url: 'E:/项目/全栈/weboffice/src/assets/plugins/html/Document/sample.pdf'},
            { name: 'sample.xlsx', url: 'E:/项目/全栈/weboffice/src/assets/plugins/html/Document/sample.xlsx'},
          ]
        }
      },
      methods: {
        eiteOnline(row) {
          this.$router.push({
            name: 'Office',
            params: {currentRow: row}
          })
        }
      },
    }
  </script>