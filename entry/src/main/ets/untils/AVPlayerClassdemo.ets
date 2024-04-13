import media from '@ohos.multimedia.media';
// import media from '@ohos.multimedia.media'
import { songItemType } from '../models/music';
// import emitter from '@ohos.events.emitter';
// import { EmitEvenType } from '../constants/EventConstants';
// import { defaultState, PlayStateType } from '../models/playState';
// import router from '@ohos.router';
// import { PreferencesClass } from './PreferencesClass';

// export default class AVPlayerClass {
//   // 创建的播放器应该存在我们的工具类上，这样才能被导出使用
//   static player: media.AVPlayer | null = null
//   //当前是否播放
//   static isPlay: boolean = false
//   //当前播放器的模式
//   static playModel: 'auto' | 'repeat' | 'random' = 'auto'
//   //当前播放歌曲总时长
//   static duration: number = 0
//   //当前歌曲正在播放时长
//   static time: number = 0
//   //当前播放器的列表
//   static playList: songItemType[] = []
//   // 当前播放音乐的索引
//   static playIndex: number = 0
//   //播放器中记录上下文
//   static context: Context = null
//   //初始化
//   // 创建播放器的发方法
//   static async init() {
//     this.player = await media.createAVPlayer()
//     // 监听播放器的状态（状态机）
//     this.player.on('stateChange', (state) => {
//       switch (state) {
//       // 初始化
//         case 'initialized':
//           this.player.prepare()
//           break;
//       // 准备
//         case 'prepared':
//         // 播放操作
//           this.player.play()
//           this.isPlay = true
//           break;
//       //播放完毕
//         case 'completed':
//           if (this.playModel === "random" && this.playList.length > 1) {
//             let index = 0
//             do {
//               index = Math.floor(Math.random() * this.playList.length)
//             } while (index === this.playIndex)
//             // 已经拿到非自身索引
//             this.playIndex = index
//           } else if (this.playModel === 'auto') {
//             this.playIndex++
//             //有可能变为负数
//             this.playIndex = (this.playIndex + this.playList.length) % this.playList.length
//           }
//           this.singlePlay(this.playList[this.playIndex])
//           break;
//         default:
//           break;
//       }
//
//     })
//     // 监听歌曲时长
//     this.player.on('durationUpdate', (duration: number) => {
//       // console.log('logData->', duration)
//       this.duration = duration
//     })
//     // 监听播放时间
//     this.player.on('timeUpdate', (time) => {
//       // console.log('logData->', time)
//       this.time = time
//       //更新页面状态 首选行
//       this.updateState()
//     })
//     //监听设置播放时长
//     this.player.on('seekDone', () => {
//       this.player.play()
//       this.isPlay = true
//     })
//   }
//   // 播放方法
//   static singlePlay(song: songItemType) {
//     // 判断是不是播放列表中的
//     const isList = this.playList.some(item => item.id === song.id)
//     if (isList) {
//       if (song.url === this.player.url) {
//         if (this.isPlay) {
//           // 重新播放
//           this.changePlay()
//         } else {
//           //继续播放
//           this.player.seek(this.time)
//         }
//       } else {
//         // 切换歌曲
//         const index = this.playList.findIndex(item => item.id === song.id)
//         this.playIndex = index
//         this.changePlay()
//       }
//     } else {
//       // 添加到列表的最前面，然后从头开始播放
//       this.playList.unshift(song)
//       this.playIndex = 0
//       this.changePlay()
//     }
//   }
//   // 切换歌曲
//   static async changePlay() {
//     // 将播放状态这是为闲置
//     await this.player.reset()
//     // 播放器状态+播放类
//     this.time = 0
//     this.duration = 0
//     this.player.url = this.playList[this.playIndex].url
//   }
//
//   // 更新页面状态 首选项
//   static async updateState() {
//     const data = {
//       playState: JSON.stringify({
//         img: this.playList[this.playIndex].img,
//         name: this.playList[this.playIndex].name,
//         author: this.playList[this.playIndex].author,
//         time: this.time,
//         duration: this.duration,
//         playMode: this.playModel,
//         isPlay: this.isPlay,
//         url: this.playList[this.playIndex].url,
//         playList: this.playList,
//         playIndex: this.playIndex
//       } as PlayStateType)
//     }
//
//     // 更新页面
//     emitter.emit({
//       eventId: EmitEvenType.UPDATE_STATE
//     }, {
//       data
//     })
//     //更新首选项
//     // 怎么获取首选项？
//     const preferences: PreferencesClass = new PreferencesClass(this.context)
//     await preferences.setPlayState(JSON.parse(data.playState))
//
//   }
//
//   //该变播放模式
//   static changeModel(model: 'auto' | 'repeat' | 'random') {
//     this.playModel = model
//     //更新页面状态
//     this.updateState()
//   }
//   //暂停播放
//   static pause() {
//     this.player.pause()
//     this.isPlay = false
//   }
//   //上一首
//   static previous() {
//     if (this.playList.length === 0) {
//       return
//     }
//     if (this.playModel === "random" && this.playList.length > 1) {
//       let index = 0
//       do {
//         index = Math.floor(Math.random() * this.playList.length)
//       } while (index === this.playIndex)
//       // 已经拿到非自身索引
//       this.playIndex = index
//     } else {
//       this.playIndex--
//       //有可能变为负数
//       this.playIndex = (this.playIndex + this.playList.length) % this.playList.length
//     }
//     this.singlePlay(this.playList[this.playIndex])
//   }
//   //下一首
//   static next() {
//     if (this.playList.length === 0) {
//       return
//     }
//     if (this.playModel === "random" && this.playList.length > 1) {
//       let index = 0
//       do {
//         index = Math.floor(Math.random() * this.playList.length)
//       } while (index === this.playIndex)
//       // 已经拿到非自身索引
//       this.playIndex = index
//     } else {
//       this.playIndex++
//       //有可能变为负数
//       this.playIndex = (this.playIndex + this.playList.length) % this.playList.length
//     }
//     this.singlePlay(this.playList[this.playIndex])
//   }
//   //删除歌曲
//   static async remove(index: number) {
//     //判断当前歌曲是否正在播放
//     if (this.playIndex === index) {
//       //判断歌曲列表中是否还有歌
//       if (this.playList.length > 1) {
//         this.playList.splice(index, 1)
//         // 播放歌曲前，要计算切换歌曲的索引
//         this.playIndex = (this.playIndex + this.playList.length) % this.playList.length
//         this.singlePlay(this.playList[this.playIndex])
//       } else {
//         // 歌曲表空 返回上一页
//         //停止播放
//         await this.player.reset()
//         this.playList.splice(index, 1)
//         this.isPlay = false
//         this.time = 0
//         this.duration = 0
//         //问题 由于状态机重置了，无法向页面推送重置后的信息
//         // this.updateState()
//         const data = {
//           playState: JSON.stringify(defaultState)
//         }
//         // 更新页面
//         emitter.emit({
//           eventId: EmitEvenType.UPDATE_STATE
//         }, {
//           data
//         })
//         router.back()
//       }
//     } else {
//       //非播放歌曲
//       //要删除歌曲在正在播放之前
//       if (this.playIndex > index) {
//         this.playIndex--
//       }
//       this.playList.splice(index, 1)
//     }
//
//   }
// }

// import { songItemType } from '../models/music'

export default  class AVPlayerClass {
  // 创建的播放器应该存在我们的工具类上，这样才能被导出使用
  static player: media.AVPlayer | null = null
  // 创建时长
  static duration: number = 0
  // 当前的播放时长（毫秒）
  static time: number = 0
  // 是否播放
  static isPlay:Boolean =false
  // 当前播放模式
  static playMode: 'auto'|'repeat'|'random' = 'auto'
  // 当前的播放列表
  static playList:songItemType[] = []
  // 当前的播放序号
  static playIndex:number = -1
  // 创建播放器的方法
  static async  init() {
    // console.log('stateChange','state')
    // 创建播放器
    this.player = await media.createAVPlayer()
    // 监听播放器状态
    this.player.on('stateChange',(state)=> {
      switch (state){
        // 初始化
        case 'initialized':
          this.player.prepare()
          break
        //       准备
        case 'prepared':
          this.player.play()
          this.isPlay = true
          break
      }
    })
    // 监听时长
    this.player.on('durationUpdate',(duration)=>{
      this.duration=duration
      // 测试打印播放列表是否添加成功
      console.log('logData:',this.playIndex)
      console.log('logData:',JSON.stringify(this.playList))
    })
    this.player.on('timeUpdate', (time) => {
      this.time = time

    })
  }
  // 单首歌播放
  static singlePlay (song:songItemType){
    this.playList.unshift(song)
    this.playIndex = 0
    // this.player.url = this.playList[this.playIndex].url
    this.changePlay()
  }
  static changeMode(mode){
    this.playMode = mode
  }
  static async changePlay(){
    await this.player.reset()
    this.duration = 0
    this.time = 0
    this.player.url = this.playList[this.playIndex].url
  }

}