
<template>
  <div class="word-wrap">
    <!-- <div class="btnWrap">
      <button @click="WebOpenLocal">打开本地文件</button>
      <div style="width: 100%;"> -->
			<!-- 以MultiPart方式下载文档,设置文件处理Servelet，打开和保存都用这个Servelet处理 -->
			<!-- <input style="color:Red;" type=button value="MultiPart方式打开文档" @click="handel1"> -->
			<!-- URL地址打开文档，WebOpen2的参数是文件在服务器上的相对路径 -->
			<!-- <input style="color:Red;" type=button value="URL地址打开文档" @click="handel2"> -->
			<!-- 服务端Servlet打开文档，WebOpen3的参数是文件在服务器上的相对路径 -->
			<!-- <input style="color:Red;" type=button value="服务端Servlet打开文档" @click="handel3">
			<input style="color:Red;" type=button value="保存文档到服务器" @click="SaveDocument">
			<input style="color:Red;" type=button value="打开本地文档(有窗口)" @click="WebOpenLocal">
			<input style="color:Red;" type=button value="保存本地文档(有窗口)" @click="WebSaveLocal">
			<input style="color:Red; width: 40%;" id="StatusBar" type="text" name="StatusBar" readonly /> -->
		<!-- </div>
    </div> -->
    <div v-if="!WebOfficeObj">正在加载中……</div>
  </div>
</template>
<script>
import Vue from "vue";
import webOfficeTpl from "../assets/plugins/html/js/iWebOffice2015.js";
// import WebOffice2015 from "../assets/plugins/html/js/WebOffice2015";
export default {
  data() {
    return {
      webOffice: null,
      WebOfficeObj: null,
      // KGBrowser: null,
      url: "",
      name: '',
      type: ''
    };
  },
  beforeCreate() {
    
  },
  mounted() {
    if (this.$route.params.currentRow) {
      this.url = this.$route.params.currentRow.url
      this.name = this.$route.params.currentRow.name
      let arr = this.$route.params.currentRow.name.split('.')
      this.type = arr[arr.length - 1]
    }
    this.$nextTick(() => {
      this.initWebOffice();
      this.$nextTick(() => {
        this.initWebOfficeObject();
        this.load();
        if (this.type && this.type !== 'pdf') {
          this.WebOfficeObj.WebOpenLocalFile(this.url)
        }
      })
    });
    console.log(this.$route.params)
  },
  beforeDestroy() {},
  methods: {
    handel1() {
      // this.OnUnLoad()
      this.load()
    },
    handel2() {
      // this.OnUnLoad()
      this.LoadURL()
    },
    handel3() {
      // this.OnUnLoad()
      this.LoadServlet()
    },
    initWebOffice() {
      const newnode = document.createElement("div");
      newnode.innerHTML = webOfficeTpl;
      newnode.style.height='400px'
      document.getElementById("office").appendChild(newnode);
      // this.webOffice = new Vue({
      //   render: h => h(webOfficeTpl)
      //   // template: webOfficeTpl
      // }).$mount('#office');
    },

    // 金格MultiPart方式在线打开文档
    load() {
      try {
        this.WebOfficeObj.ServerUrl = this.url;
        this.WebOfficeObj.UserName = "演示人";
        // this.WebOfficeObj.FileName = "sample.doc";
        // this.WebOfficeObj.FileType = ".doc"; //FileType:文档类型  .doc  .xls
        this.WebOfficeObj.FileName = `sample.${this.type}`;
		    this.WebOfficeObj.FileType = `.${this.type}`; 
        this.WebOfficeObj.ShowWindow = true; //true显示进度条//false隐藏进度条
        this.WebOfficeObj.obj.Style.ShowOpenProgress = true; //开启、关闭打开文档时的进度条
        this.WebOfficeObj.obj.WebCreateProcess(); //创建空进程避免打开慢
        this.WebOfficeObj.EditType = "1"; //设置加载文档类型 0 锁定文档，1无痕迹模式，2带痕迹模式
        this.WebOfficeObj.ShowMenu = "1";
        this.WebOfficeObj.ShowToolBar = 1;
        // WebOfficeObj.SetCaption(WebOfficeObj.UserName + "正在编辑文档");

        this.SetGraySkin(); //设置控件皮肤
        if (this.WebOfficeObj.WebOpen()) {
          this.StatusMsg(this.WebOfficeObj.Status);
        }
      } catch (e) {
        this.StatusMsg(e.description);
      }
    },
    //烟枪灰皮肤
    SetGraySkin() {
      //参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
      //自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
      if ( !this.WebOfficeObj.WebSetSkin(0xdbdbdb,0xeaeaea,0xeaeaea,0xdbdbdb,0xdbdbdb,0xdbdbdb,0x000000))
        this.WebOfficeObj.Alert(this.WebOfficeObj.Status);
    },

    //URL地址打开文档
    LoadURL() {
      try {
        this.WebOfficeObj.ServerUrl = this.url; //服务器地址
        this.WebOfficeObj.ShowMenu = 0;
        this.WebOfficeObj.ShowToolBar = 0;
        this.SetGraySkin(); //设置控件皮肤
        // this.WebOfficeObj.WebOpen(this.name)
        // this.WebOfficeObj.WebOpenLocalFile(this.url)
        if (this.WebOfficeObj.WebOpen2("/Document/sample.doc")) {
          // 文件在服务器上的相对路径 FileName
          this.StatusMsg(this.WebOfficeObj.Status);
        }
      } catch (e) {
        this.StatusMsg(e.description);
      }
    },

    //服务端Servlet方式打开文档
    LoadServlet() {
      try {
        this.WebOfficeObj.ServerUrl = this.url; // 用来保存文件的Server
        var downloadLink = this.url + "/FileDownload?FileName=" + "/Document/sample.doc";
        this.WebOfficeObj.ShowMenu = 0;
        this.WebOfficeObj.ShowToolBar = 0;
        this.SetGraySkin(); //设置控件皮肤
        if (this.WebOfficeObj.WebOpen3(downloadLink)) {
          // 文件在服务器上的相对路径 FileName
          this.StatusMsg(this.WebOfficeObj.Status);
        }
      } catch (e) {
        this.StatusMsg(e.description);
      }
    },

    //设置页面中的状态值
    StatusMsg(mValue) {
      try {
        document.getElementById("StatusBar").value = mValue;
      } catch (e) {
        return false;
      }
    },

    //保存文档
    SaveDocument() {
      this.WebOfficeObj.FileName = "sample.doc";
      this.WebOfficeObj.FileType = ".doc";
      if (this.WebOfficeObj.WebSave()) {
        //交互OfficeServer的OPTION="SAVEFILE"
        this.WebOfficeObj.WebClose();
        window.close();
      } else {
        this.WebOfficeObj.Alert(this.WebOfficeObj.Status);
        this.StatusMsg(this.WebOfficeObj.Status);
      }
    },

    OnUnLoad() {
      this.WebOfficeObj.WebClose();
    },

    OnReady() {
      this.WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
      //Load();//避免页面加载完，控件还没有加载情况
      setTimeout(() => {
        this.load()
      }, 500)
    },

    initWebOfficeObject() {
      this.WebOfficeObj = new WebOffice2015();
      // this.KGBrowser = new KGBrowser();
      this.WebOfficeObj.setObj(document.getElementById("WebOffice"));
      try {
      } catch (e) {
        // console.log("catch");
        // console.log(e.description);
      }
    },
    WebOpenLocal() {
      this.WebOfficeObj.WebOpenLocal();
    },
    WebSaveLocal() {
      this.WebOfficeObj.WebSaveLocal();
    },
  }
};
</script>
 
<style scoped>
/* .word-wrap {
  width: 100%;
  height: 800px;
} */
</style>