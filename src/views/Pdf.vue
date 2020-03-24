<template>
  <div id="pdf">
    
  </div>
</template>

<script>
import PDF from "../assets/iWebPDF2018/js/copyiWebPDF2018.js";
export default {
  methods: {
    initWebOffice() {
      const newnode = document.createElement("div");
      newnode.innerHTML = PDF;
      newnode.style.height= document.documentElement.clientHeight - 120 + 'px'
      document.getElementById("pdf").appendChild(newnode);
    },
    openURLFile() {
      try{
      var addin = iWebPDF2018.iWebPDFFun;
      console.log(addin)
      console.log(this.url)
      addin.WebOpenLocal(this.url);
    }catch(e){
      alert(e.description);
    }
    }
  },
  data() {
    return {
      url: '',
      name: ''
    }
  },
  mounted () {
    this.initWebOffice()
    if (this.$route.query.currentRow) {
      let params = JSON.parse(this.$Base64.decode(this.$route.query.currentRow))
      this.url = params.url
      this.name = params.name
    }
    this.$nextTick(() => {
      this.openURLFile()
    })
  },
}
</script>