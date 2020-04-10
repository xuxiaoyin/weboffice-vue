<template>
  <el-dialog title="跳转到指定日期" :visible.sync="dialogVisible" width="480px">
  <el-form :model="form" label-width="100px">
    <el-form-item label="指定日期">
       <el-date-picker
        v-model="form.date"
        type="date"
        placeholder="选择日期">
      </el-date-picker>
    </el-form-item>
  </el-form>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible = false" size="small">取 消</el-button>
    <el-button type="primary" @click="sureGoto" size="small">确 定</el-button>
  </span>
  </el-dialog>
</template>

<script>
export default {
  data() {
    return {
      dialogVisible: false,
      form: {
        date: ''
      }
    }
  },
  methods: {
    show() {
      this.form.date = ''
      this.dialogVisible = true
    },
    sureGoto() {
      this.dialogVisible = false
      this.$emit('sureGoto', this.form.date)
    }
  }
}
</script>