<template>
  <div class='demo-app'>
    <div class='demo-app-top'>
      <button @click="toggleWeekends">toggle weekends</button>
      <button @click="gotoPast">go to a date in the past</button>
      (also, click a date/time to add an event)
    </div>
    <FullCalendar
      class='demo-app-calendar'
      ref="fullCalendar"
      defaultView="dayGridMonth"
      :header="{
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
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
      @select="daySelect"
      @dateClick="handleDateClick"
      />
      <add-event ref="addEvent" :title="title"></add-event>
  </div>
</template>

<script>
import FullCalendar from '@fullcalendar/vue'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import listPlugin from '@fullcalendar/list';
import AddEvent from './components/AddEvent'
export default {
  components: {
    FullCalendar, // make the <FullCalendar> tag available
    AddEvent
  },
  data: function() {
    return {
      calendarPlugins: [ // plugins must be defined in the JS
        dayGridPlugin,
        timeGridPlugin,
        interactionPlugin, // needed for dateClick
        listPlugin
      ],
      calendarWeekends: true,
      calendarEvents: [ // initial event data
        { id: 1, title: 'Event Now', start: '2020-03-16', end: '2020-03-18' }
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
        list: '列表'
      },
      navLinks: true, // 允许天/周名称是否可点击，包括周次weekNumber，点击之后可以跳转到对于的天/周视图
      title: ''
    }
  },
  methods: {
    toggleWeekends() {
      this.calendarWeekends = !this.calendarWeekends // update a property
    },
    gotoPast() {
      let calendarApi = this.$refs.fullCalendar.getApi() // from the ref="..."
      calendarApi.gotoDate('2000-01-01') // call a method on the Calendar object
    },
    handleDateClick(arg) {
      this.title = '新增事件'
      console.log(arg)
      this.$refs.addEvent.show()
    },
    daySelect(arg) {
      // console.log(this.calendarEvents)
      // console.log(arg)
    }
  }
}
</script>

<style>
@import '~@fullcalendar/core/main.css';
@import '~@fullcalendar/daygrid/main.css';
@import '~@fullcalendar/timegrid/main.css';
.demo-app {
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
</style>