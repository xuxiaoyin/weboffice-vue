<template>
  <el-dialog title="权限配置" :visible.sync="dialogVisible" width="80%">
    <rights></rights>
    <span slot="footer" class="dialog-footer">
      <el-button @click="dialogVisible = false" size="small">取 消</el-button>
      <el-button type="primary" @click="dialogVisible = false" size="small">确 定</el-button>
    </span>
  </el-dialog>
</template>

<script>
import Rights from './SetRights'
export default {
  components: {
    Rights
  },
  data() {
    return {
      dialogVisible: false
    }
  },
  methods: {
    show() {
      this.dialogVisible = true
    }
  }
}
</script>