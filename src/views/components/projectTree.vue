<template>
  <div class="tree">
    <div class="inputBox">
      <el-input
        placeholder="输入关键字进行过滤"
        v-model="filterText">
      </el-input>
    </div>
    <el-tree
      class="filter-tree"
      show-checkbox
      node-key="id"
      :default-expanded-keys="expandedKeys"
      :default-checked-keys="checkedKeys"
      :data="data"
      :props="defaultProps"
      :filter-node-method="filterNode"
      ref="tree">
    </el-tree>
  </div>
</template>

<script>
export default {
  data() {
    return {
      filterText: '',
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
      defaultProps: {
        children: 'children',
        label: 'label'
      },
      expandedKeys: [],
      checkedKeys: []
    }
  },
  methods: {
    filterNode(value, data) {
      if (!value) return true;
      return data.label.indexOf(value) !== -1;
    }
  },
  watch: {
    filterText(val) {
      this.$refs.tree.filter(val);
    }
  },
}
</script>

<style lang="css" scoped>
.inputBox {
  width: 240px;
  margin-bottom: 20px;
}
</style>