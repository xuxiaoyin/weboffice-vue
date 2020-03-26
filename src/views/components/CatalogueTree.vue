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
      @node-contextmenu="changeShowBtn"
      @node-click="nodeClick"
      ref="tree">
      <div  class="custom-tree-node"  slot-scope="{ node }">
        <span :title="node.label"> {{ node.label }}</span>
      </div>
    </el-tree>
    <el-card class="btnWrap" v-show="showBtn" id="showBtn">
      <div v-if="showBtn">
        <div class="item">
          <el-button size="small" type="text" @click="add('新增')">新增</el-button>
        </div>
        <div class="编辑">
          <el-button size="small" type="text">编辑</el-button>
        </div>
        <div class="删除">
          <el-button size="small" type="text">删除</el-button>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      filterText: '',
      data:[{
        id: 1,
        label: '目录1',
        children: [{
          id: 4,
          label: '目录1-1',
          children: [{
            id: 9,
            label: '目录1-1-1',
            children : [{id: 91,label: '目录1-1-1-1很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多'},{id: 92,label: '目录1-1-1-2',}]
          }, {
            id: 10,
            label: '目录1-1-2',
            children : [{id: 11, label: '目录1-1-2-1很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多很多很多文字很多很多'},{id: 12,label: '目录1-1-2-2',}]
          }]
        },
        {
          id: 40,
          label: '目录1-2',
          children: [{
            id: 90,
            label: '目录1-2-1',
            children : [{id: 910,label: '目录1-2-1-1'},{id: 920,label: '目录1-2-1-2'}]
          }, {
            id: 100,
            label: '目录1-2-2',
            children : [{id: 110,label: '目录1-2-2-1'},{id: 120,label: '目录1-2-2-2'}]
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
            children : [{id: 915,label: '目录1'},{id: 925,label: '目录2',}]
          }, {
            id: 105,
            label: '目录2',
            children : [{id: 115, label: '目录1'},{id: 125,label: '目录2',}]
          }]
        },
        {
          id: 405,
          label: '项目目录',
          children: [{
            id: 905,
            label: '目录1',
            children : [{id: 9105,label: '目录1'},{id: 9205,label: '目录2'}]
          }, {
            id: 1005,
            label: '目录2',
            children : [{id: 1105,label: '目录1'},{id: 1205,label: '目录2'}]
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
            children : [{id: 913,label: '目录1'},{id: 923,label: '目录2',}]
          }, {
            id: 103,
            label: '目录2',
            children : [{id: 113, label: '目录1'},{id: 123,label: '目录2',}]
          }]
        },
        {
          id: 403,
          label: '项目目录',
          children: [{
            id: 903,
            label: '目录1',
            children : [{id: 9103,label: '目录1'},{id: 9203,label: '目录2'}]
          }, {
            id: 1003,
            label: '目录2',
            children : [{id: 1103,label: '目录1'},{id: 1203,label: '目录2'}]
          }
          ]}
        ]}
      ],
      defaultProps: {
        children: 'children',
        label: 'label'
      },
      expandedKeys: [],
      checkedKeys: [],
      showBtn: false
    }
  },
  mounted() {

  },
  methods: {
    // 监听右键事件
    changeShowBtn(event, data, node, sele) {
      this.showBtn = false
      this.showBtn = true
      var menu = document.querySelector('#showBtn');
      console.log(menu)
      menu.style.left = event.clientX + 5 + 'px';
      document.addEventListener('click', this.foo); // 给整个document添加监听鼠标事件，点击任何位置执行foo方法
      menu.style.top = event.clientY - 90 + 'px'
    },
    foo() {
      this.showBtn = false
      document.removeEventListener('click', this.foo) 
    },
    nodeClick() {
      this.showBtn = false
    },
    // 过滤
    filterNode(value, data) {
      if (!value) return true;
      return data.label.indexOf(value) !== -1;
    },
    add(text) {
      console.log(text)
    }
  },
  watch: {
    filterText(val) {
      this.$refs.tree.filter(val);
    }
  }
}
</script>

<style lang="css">
  #showBtn .el-card__body {
    padding: 10px 20px;
  }
  /* .el-tree {
    width: 100%;
    overflow-x: scroll;
  }

.el-tree>.el-tree-node {
  display: inline-block;
  min-width: 100%;
} */
</style>

<style lang="css" scoped>
.inputBox {
  width: 240px;
  margin-bottom: 20px;
}
.filter-tree {
  position: relative;
}
.btnWrap {
  width: 70px;
  position: absolute;
  z-index: 9999;
}
.custom-tree-node {
  font-size: 14px;
}
</style>