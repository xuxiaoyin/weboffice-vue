<template>
  <div>
    <el-dialog title="指定文件" :visible.sync="dialogVisible" width="640px">
      <el-form label-width="100px" >
        <el-form-item label="选择文件">
          <treeselect
            v-model="checkedList"
            :multiple="true"
            :options="data"
            placeholder="请选择指定文件"
            :flat="true"
            :default-expand-level="1"
          />
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="dialogVisible = false" size="small">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
// import the component
import Treeselect from '@riophae/vue-treeselect'
// import the styles
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
export default {
  components: { Treeselect },
  data() {
    return {
      dialogVisible: false,
      checkedList: [],
      data:[{
        id: 1,
        label: '项目1',
        children: [{
          id: 4,
          label: '底稿目录',
          children: [{
            id: 9,
            label: '目录1',
            children : [{id: 91,label: '文件1'},{id: 92,label: '文件2',}]
          }, {
            id: 10,
            label: '目录2',
            children : [{id: 11, label: '文件1'},{id: 12,label: '文件2',}]
          }]
        },
        {
          id: 40,
          label: '项目目录',
          children: [{
            id: 90,
            label: '目录1',
            children : [{id: 910,label: '文件1'},{id: 920,label: '文件2'}]
          }, {
            id: 100,
            label: '目录2',
            children : [{id: 110,label: '文件1'},{id: 120,label: '文件2'}]
          }
          ]}
        ]},
        {
        id: 15,
        label: '项目2',
        children: [{
          id: 45,
          label: '底稿目录',
          children: [{
            id: 95,
            label: '目录1',
            children : [{id: 915,label: '文件1'},{id: 925,label: '文件2',}]
          }, {
            id: 105,
            label: '目录2',
            children : [{id: 115, label: '文件1'},{id: 125,label: '文件2',}]
          }]
        },
        {
          id: 405,
          label: '项目目录',
          children: [{
            id: 905,
            label: '目录1',
            children : [{id: 9105,label: '文件1'},{id: 9205,label: '文件2'}]
          }, {
            id: 1005,
            label: '目录2',
            children : [{id: 1105,label: '文件1'},{id: 1205,label: '文件2'}]
          }
          ]}
        ]},
        {
        id: 13,
        label: '项目3',
        children: [{
          id: 43,
          label: '底稿目录',
          children: [{
            id: 93,
            label: '目录1',
            children : [{id: 913,label: '文件1'},{id: 923,label: '文件2',}]
          }, {
            id: 103,
            label: '目录2',
            children : [{id: 113, label: '文件1'},{id: 123,label: '文件2',}]
          }]
        },
        {
          id: 403,
          label: '项目目录',
          children: [{
            id: 903,
            label: '目录1',
            children : [{id: 9103,label: '文件1'},{id: 9203,label: '文件2'}]
          }, {
            id: 1003,
            label: '目录2',
            children : [{id: 1103,label: '文件1'},{id: 1203,label: '文件2'}]
          }
          ]}
        ]}
      ],
    }
  },
  methods: {
    show() {
      this.dialogVisible = true
    }
  }
}
</script>