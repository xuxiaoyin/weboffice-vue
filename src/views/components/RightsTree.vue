<template>
  <div>
    <el-tree
      class="filter-tree"
      show-checkbox
      node-key="id"
      :default-expanded-keys="expandedKeys"
      :default-checked-keys="checkedKeys"
      :data="data"
      :props="defaultProps"
      @check-change="checkChange"
      ref="tree">
    </el-tree>

    <file-dia ref="fileDia"></file-dia>
  </div>
</template>

<script>
import FileDia from './FileDia'
export default {
  components: {
    FileDia
  },
  data() {
    return {
      data: [
        {
          id: '1',
          label: '查看',
          children: [
            { id: '11', label: '项目', roles: [1,3,5,8,6]},
            { id: '12', label: '所有文件', roles: [2,4,6,8,10]},
            { id: '13', label: '已审核文件', roles: [2,4,5,8,10]},
            { id: '14', label: '指定文件', roles:[1,3,4,5,8,10]}
          ]
        },
        {
          id: '2',
          label: '编辑',
          children: [
            { id: '21', label: '项目', roles:[1,3,4]},
            { id: '22', label: '目录', roles:[5,8,10]},
            { id: '23', label: '文件', roles:[1,3,4,10]},
            { id: '24', label: '项目人员',roles:[1,3,4,5]},
          ]
        },
        {
          id: '3',
          label: '删除',
          children: [
            { id: '31', label: '终止项目',roles:[3,4,5,8,10]},
            { id: '32', label: '删除项目', roles:[1,3,4,10]},
            { id: '33', label: '删除文件',roles:[2,3,4,5,6,10]},
          ]
        },
        {
          id: '4',
          label: '新增',
          children: [
            { id: '41', label: '新增目录', roles:[1,2,4,5,8,10]},
            { id: '42', label: '上传文件', roles:[1,4,5,8,10]}
          ]
        }
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
    checkChange(data, flag) {
      if (data.label === "指定文件" && flag)  {
        this.$refs.fileDia.show()
      }
    },
  },
  mounted() {
    this.$parent.$on('roleChange', (val, flag) => {
      console.log(456)
      console.log(val)
      console.log(flag)
    })
  }
}
</script>