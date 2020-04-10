<template>
  <div class='demo-app'>
    <div class='demo-app-top'>
      <el-button @click="toggleWeekends" type="primary" size="small">周末切换</el-button>
      <el-button @click="gotoPast" type="primary" size="small">跳转到指定日期</el-button>
    </div>
    <FullCalendar
      class='demo-app-calendar'
      ref="fullCalendar"
      defaultView="dayGridMonth"
      :header="{
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
      }"
      :plugins="calendarPlugins"
      :weekends="calendarWeekends"
      :events="calendarEvents"
      locale="zh-cn"
      firstDay="1"
      weekNumberCalculation="ISO" 
      :buttonText="buttonText"
      :droppable="true"
      :editable="true"
      :selectable="true"
      :navLinks="navLinks"
      :allDayText="'全天'"
      @select="daySelect"
      @dateClick="handleDateClick"
      @eventClick="eventClick"
      @eventMouseEnter="eventMouseEnter"
      @eventMouseLeave="eventMouseLeave"
      />
      <add-event ref="addEvent" :currentEvent="currentEvent" :title="title" @sureAdd="sureAdd"></add-event>
      <date-dia ref="dateDia" @sureGoto="sureGoto"></date-dia>

      <div class="infoWrap" @mouseover="changeShowDetail" @mouseout="changeShowDetail1">
        <el-card v-show="showDetail">
          <div class="item">
            <span class="name">事件名称：</span>
            <span class="detail">{{mouseEvent.title}}</span>
          </div>
          <div class="item" v-if="mouseEvent.extendedProps && mouseEvent.extendedProps.content">
            <span class="name">事件内容：</span>
            <span class="detail">{{mouseEvent.extendedProps.content}}</span>
          </div>
          <div class="item" v-if="mouseEvent.start">
            <span class="name">开始时间：</span>
            <span class="detail">{{parseTime(mouseEvent.start)}}</span>
          </div>
          <div class="item" v-if="mouseEvent.end">
            <span class="name">结束时间：</span>
            <span class="detail">{{parseTime(mouseEvent.end)}}</span>
          </div>
          <div class="item" style="text-align: right;">
            <el-button type="warning" size="small">删除</el-button>
          </div>
        </el-card>
      </div>
  </div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import listPlugin from '@fullcalendar/list';
import AddEvent from './components/AddEvent'
import DateDia from './components/DateDia'

export default {
  components: {
    FullCalendar, // make the <FullCalendar> tag available
    AddEvent,
    DateDia
  },
  data: function() {
    return {
      calendarPlugins: [ // plugins must be defined in the JS
        dayGridPlugin,
        timeGridPlugin,
        interactionPlugin, // needed for dateClick
        listPlugin,
        timeGridPlugin 
      ],
      calendarWeekends: true,
      calendarEvents: [ // initial event data
        { id: 1, title: '测试', start: '2020-03-16', end: '2020-03-18', allDay: true },
        { id: 2, title: '测试1', start: '2020-03-15', allDay: true },
        { id: 3, title: '测试1', start: '2020-03-14', allDay: true },
        { id: 4, title: '测试1', start: '2020-03-24', allDay: true },
        { title: 'My Event', start: '2020-03-01', description: 'This is a cool event', allDay: true }
      ],
      buttonText: {
        prev: '上月', // ‹
        next: '下月', // ›
        prevYear: '去年', // «
        nextYear: '明年', // »
        today: '今天',
        month: '月',
        week: '周',
        day: '天',
        list: '事件列表'
      },
      navLinks: true, // 允许天/周名称是否可点击，包括周次weekNumber，点击之后可以跳转到对于的天/周视图
      title: '',
      currentEvent: {},
      mouseEvent: {},
      showDetail: false,
      timer: null
    }
  },
  methods: {
    toggleWeekends() {
      this.calendarWeekends = !this.calendarWeekends // update a property
    },
    gotoPast() {
      this.$refs.dateDia.show()
      // calendarApi.gotoDate('2000-01-01') // call a method on the Calendar object
    },
    sureGoto(date) {
      let calendarApi = this.$refs.fullCalendar.getApi() // from the ref="..."
      calendarApi.gotoDate(date)
    },
    handleDateClick(arg) {
      this.title = '新增事件'
      console.log(arg)
      this.currentEvent.start = arg.date
       this.currentEvent.end = ''
      this.$refs.addEvent.show()
    },
    daySelect(arg) {
      console.log(arg)
       this.currentEvent.start = arg.start
       this.currentEvent.end = arg.end
       this.$refs.addEvent.show()
      // console.log(this.calendarEvents)
      // console.log(arg)
    },
    sureAdd(form) {
      this.calendarEvents.push(form)
    },
    // 点击事件
    eventClick(event) {
      console.log(event)
      this.currentEvent = event.event
      this.title = '编辑事件'
      this.$refs.addEvent.show()
    },
    // 鼠标移入事件
    eventMouseEnter(event) {
      console.log(event)
      clearTimeout(this.timer)
      this.timer = setTimeout(() => {
        this.showDetail = true
        this.mouseEvent = event.event
        const el = document.querySelector('.infoWrap')
        el.style.top = event.jsEvent.pageY - 70 + 'px'
        el.style.left = event.jsEvent.pageX + 'px'
      }, 20)
    },
    // 鼠标移出
    eventMouseLeave() {
      clearTimeout(this.timer)
      this.timer = setTimeout(() => {
        this.showDetail = false
      }, 100)
    },
    changeShowDetail() {
      clearTimeout(this.timer)
      this.showDetail = true
    },
    changeShowDetail1() {
      clearTimeout(this.timer)
      this.showDetail = false
    },
    // 转换时间格式
    parseTime(d) {
        const newDate = d.getFullYear() + '-' + this.p((d.getMonth() + 1)) + '-' + this.p(d.getDate()) + ' '
                        + this.p(d.getHours()) + ':' + this.p(d.getMinutes()) + ':' + this.p(d.getSeconds());
        return newDate;
    },
     p(s) {
      return s < 10 ? '0' + s : s
    },
  }
}
</script>

<style>
@import '~@fullcalendar/core/main.css';
@import '~@fullcalendar/daygrid/main.css';
@import '~@fullcalendar/timegrid/main.css';
.demo-app {
  position: relative;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}
.demo-app-top {
  margin: 0 0 3em;
}
.demo-app-calendar {
  margin: 0 auto;
  max-width: 900px;
}
.infoWrap {
 width: 400px;
 position: absolute;
 z-index: 999;
 top: 0;
 left: 0;
}
</style>