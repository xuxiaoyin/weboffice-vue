<template>
  <el-dialog :title="title" :visible.sync="dialogVisible" width="640">
    <el-form ref="form" :model="form" label-width="100px" label-position="right" size="small">
      <el-form-item label="事件名称" prop="title">
        <el-input v-model="form.title" placeholder="请输入事件名称"></el-input>
      </el-form-item>
      <el-form-item label="开始时间" prop="start">
        <el-date-picker
          style="width: 100%"
          v-model="form.start"
          :type="type"
          placeholder="选择日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="结束日期" prop="end">
        <el-date-picker
          style="width: 100%"
          v-model="form.end"
          :type="type"
          placeholder="选择日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="通知角色" v-if="form.isSendMessage">
        <el-select
          v-model="form.role"
          multiple
          collapse-tags
          style="width: 100%;"
          placeholder="请选择需要通知的角色">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-checkbox v-model="form.allDay">全天</el-checkbox>
        <el-checkbox v-model="form.isSendMessage">是否需要发送通知邮件</el-checkbox>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="warning" size="small" style="float: left;" v-if="title === '编辑事件'">删 除</el-button>
      <el-button @click="dialogVisible = false" size="small">取 消</el-button>
      <el-button type="primary" @click="dialogVisible = false" size="small">确 定</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  props: {
    title: String,
    currentEvent: Object
  },
  data() {
    return {
      dialogVisible: false,
      form: {
        id: '',
        title: '',
        start: '',
        end: '',
        isSendMessage: false,
        allDay: true,
        role: []
      },
      options: [{
        value: '选项1',
        label: '黄金糕'
      }, {
        value: '选项2',
        label: '双皮奶'
      }, {
        value: '选项3',
        label: '蚵仔煎'
      }, {
        value: '选项4',
        label: '龙须面'
      }, {
        value: '选项5',
        label: '北京烤鸭'
      }],
    }
  },
  computed: {
    type() {
      if (this.form.allDay) {
        return 'date'
      } else {
        return 'datetime'
      }
    }
  },
  methods: {
    show() {
      this.$nextTick(() => {
        this.dialogVisible = true
      })
    }
  },
}
</script>