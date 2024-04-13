interface  songItemType {
  img: string
  name: string
  author: string
  url: string
  id:string
}

interface PlayStateType {
  img: string
  name: string
  author: string
  url: string
  playIndex: number
  time: number
  duration: number
  isPlay: boolean
  playMode: 'auto' | 'repeat' | 'random'
  playList: songItemType[]
}

import media from '@ohos.multimedia.media'
import emitter from '@ohos.events.emitter'

export default class AVPlayerClass{
  //属性
  //在AVPlayerClass类上存放一个播放器
  // 1.创建的播放器应该存在我们的工具类上，这样才能被导出使用
  static player : media.AVPlayer | null = null
  // 2.播放歌曲的总时长
  static duration:number = 0
  // 3.当前播放进度的时长
  static time:number = 0
  // 4.当前是否播放
  static isPlay: boolean = false
  // 5.当前播放模式
  static playMode: 'auto'|'repeat'|'random' = 'random'
  // 6.当前的播放列表
  static playList:songItemType[] = []
  // 7.当前的播放序号
  static playIndex:number = -1

  //方法
  // 1.创建播放器的方法
  static async init(){
    // 1.1创建播放器
    this.player = await media.createAVPlayer()
    //1.2创建播放器监听器，监听播放器状态
    this.player.on('stateChange',(state)=>{
      switch (state){
        //状态：初始化
        case 'initialized':
          this.player.prepare()
          break
        //状态：准备播放
        case 'prepared':
          this.player.play()
          this.isPlay = true//当前是否播放,默认播放
          break
      //   播放完成
        case 'completed':
          if (this.playMode==='random' && this.playList.length>1){
            let index = 0
            do {
              index = Math.floor(Math.random() * this.playList.length)
            } while (index === this.playIndex)
            // 已经拿到非自身索引
            this.playIndex = index
          }
          else if(this.playMode==='random' && this.playList.length<=1 || this.playMode==='repeat'){
            this.playIndex===this.playIndex
          }
          else {
            if (this.playIndex===this.playList.length-1){
              this.playIndex = 0
            }else {
              this.playIndex++
            }
          }
          this.changePlay()

      }
    })
    //1.3监听播放歌曲的总时长的变化
    this.player.on('durationUpdate',(duration)=>{
      // console.log('logDate',duration)
      // 测试打印播放列表是否添加成功
      // console.log('logData:',this.playIndex)
      // console.log('logData:',JSON.stringify(this.playList))
      //播放歌曲的总时长的变化时会触发
      this.duration = duration
    })
    //1.4监听当前播放歌曲的进度
    this.player.on('timeUpdate',(time)=>{
      //打印当前播放歌曲的进度的日志
      //console.log('logDate',time)
      //当前播放歌曲的进度
      this.time = time
      //更新数据至页面
      this.updateState({
        img: this.playList[this.playIndex].img,
        name: this.playList[this.playIndex].name,
        author: this.playList[this.playIndex].author,
        url: this.playList[this.playIndex].url,
        playIndex: this.playIndex,
        time: this.time,
        duration: this.duration,
        isPlay: this.isPlay,
        playMode: this.playMode,
        playList: this.playList
      })
    })
  }
  //singlePlay方法，是播放的核心：其核心是找到播放‘索引’，然后切歌
  // 如果是新歌：索引为0
  // 如果是列表中的歌，则fingIndex查找索引，如果是正在播放的歌，则索引不变
  // 如果不是列表中的歌，则添加到播放列表中，再进行播放
  // 2.单首歌播放
  static singlePlay(song:songItemType){
    //通过some查找，isList是否为播放列表中的歌
    const isList = this.playList.some((item) =>{
      return item.id === song.id
    })

    if(isList){
      //isList为true，isList是播放列表中的歌
      //在判断是否为当前播放的歌
      if(this.playList[this.playIndex].id === song.id){
        // 继续播放
        this.player.play()
        this.isPlay = true
        //是，进入页面
      }else {
        //否，进入页面，并切歌，切歌= 切换播放索引 + 重置播放器 + 设置播放源
        this.playIndex = this.playList.findIndex((item)=>{//通过findIndex查找索引
          return item.id === song.id
        })
        this.changePlay()
      }
    }else {
      //isList为false，isList不是是播放列表中的歌
      // 添加到播放列表中，再进行播放
      this.playList.unshift(song)   //unshift是从列表头部添加内容
      this.playIndex = 0
      //调用切换歌曲的方法，更改播放源的url
      this.changePlay()
    }

  }
  // 3.切换播放模式
  static changeMode(mode){
    this.playMode = mode
    this.updateState({
      img: this.playList[this.playIndex].img,
      name: this.playList[this.playIndex].name,
      author: this.playList[this.playIndex].author,
      url: this.playList[this.playIndex].url,
      playIndex: this.playIndex,
      time: this.time,
      duration: this.duration,
      isPlay: this.isPlay,
      playMode: this.playMode,
      playList: this.playList
    })
  }
  //4. 切换歌曲
  static async changePlay(){
    // 通过reset重置播放器状态至初始化
    await this.player.reset()
    // 重置播放状态
    this.duration = 0
    this.time = 0
    //更改播放源的url
    this.player.url = this.playList[this.playIndex].url
  }
  //5. 更新数据至页面
  static updateState(playState:PlayStateType){
    //使用线程通信工具emitter的emit发布数据
    emitter.emit({
      eventId: 0    //0是播放器发布事件的ID，是自定义的
    },{
      data:{
        data:JSON.stringify(playState)
      }
    })

  }
  // 6.暂停
  static pause(){
    this.player.pause()
    // 更新播放器状态
    this.isPlay = false
  }
  // 上一首
  static prev(){
    if (this.playMode==='random' && this.playList.length>1){
            let index = 0
            do {
              index = Math.floor(Math.random() * this.playList.length)
            } while (index === this.playIndex)
            // 已经拿到非自身索引
            this.playIndex = index
    }else {
      if (this.playIndex===0){
        this.playIndex = this.playList.length-1
      }else {
        this.playIndex--
      }
    }
    this.changePlay()
  }
  // 下一首
  static next(){
    if (this.playMode==='random' && this.playList.length>1){
      let index = 0
      do {
        index = Math.floor(Math.random() * this.playList.length)
      } while (index === this.playIndex)
      // 已经拿到非自身索引
      this.playIndex = index
    }else {
      if (this.playIndex===this.playList.length-1){
        this.playIndex = 0
      }else {
        this.playIndex++
      }
    }
    this.changePlay()
  }

}