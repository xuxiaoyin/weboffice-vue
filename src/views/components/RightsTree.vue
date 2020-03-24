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
      ref="tree">
    </el-tree>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: [
        {
          id: '1',
          label: '查看',
          children: [
            { id: '11', label: '项目'},
            { id: '12', label: '所有文件'},
            { id: '13', label: '已审核文件'},
            { id: '14', label: '指定文件'},
          ]
        },
        {
          id: '2',
          label: '编辑',
          children: [
            { id: '21', label: '项目'},
            { id: '22', label: '目录'},
            { id: '23', label: '文件'},
            { id: '22', label: '项目人员'},
          ]
        },
        {
          id: '3',
          label: '删除',
          children: [
            { id: '31', label: '终止项目'},
            { id: '32', label: '删除项目'},
            { id: '33', label: '删除文件'},
          ]
        },
        {
          id: '4',
          label: '新增',
          children: [
            { id: '41', label: '新增目录'},
            { id: '42', label: '上传文件'}
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
  }
}
</script>