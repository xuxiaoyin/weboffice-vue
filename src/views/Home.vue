 <template>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="name" label="文件名"> </el-table-column>
      <el-table-column align="center" width="100">
        <template slot-scope="scope">
          <el-button type="text" size="mini" @click="eiteOnline(scope.row)" v-if="scope.row.name && scope.row.name.split('.')[scope.row.name.split('.').length-1]!== 'pdf'">在线编辑</el-button>
          <el-button type="text" size="mini" @click="openFile(scope.row)" v-else>打开</el-button>
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
            { name: 'sample.pdf', url: 'E:\\项目\\全栈\\weboffice\\src\\assets\\plugins\\html\\Document\\sample.pdf'},
            { name: 'sample.xlsx', url: 'E:/项目/全栈/weboffice/src/assets/plugins/html/Document/sample.xlsx'},
            { name: 'iWebOffice2015.pptx', url: 'E:/项目/全栈/weboffice/src/assets/plugins/html/Document/iWebOffice2015.pptx'},
          ]
        }
      },
      methods: {
        eiteOnline(row) {
          this.$router.push({
            path: '/office',
            query: {
              currentRow: this.$Base64.encode(JSON.stringify({...row}))
            }
          })
        },
        openFile(row) {
          console.log(row.url)
          window.open(row.url)
        },
      },
    }
  </script>