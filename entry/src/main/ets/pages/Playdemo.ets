import emitter from '@ohos.events.emitter'
import router from '@ohos.router'
import { EmitEvenType } from '../constants/EventConstants'
// import { songItemType } from '../models/music'
import { PlayStateType, PlayStateTypeModel } from '../models/playState'
import { songs } from '../constants/musicsj'
import AVPlayerClass from '../untils/AVPlayerClass'
import preferences from '@ohos.data.preferences'
import { PreferencesClass } from '../untils/PreferencesClass'
// import router from '@ohos.router'

// struct Play {
//   @State opacityNum: number = 1
//   @State panelHeight: string = '0%'
//
//   //动画需要的数据
//   @State randomColor: string = 'rgb(0,0,0)'
//   @State randomShakeX: number = 0
//   @State randomShakeY: number = 0
//   @State rotateAngle: number = 0
//   time: number = -1
//   // 时长数字(ms)转字符串
//   number2time(number: number) {
//     const ms: number = number % 1000
//     const second = (number - ms) / 1000
//     const s: number = second % 60
//     if (second > 60) {
//       const m: number = (second - s) / 60 % 60
//       return m.toString()
//         .padStart(2, '0') + ':' + s.toString()
//         .padStart(2, '0')
//     }
//     return '00:' + s.toString()
//       .padStart(2, '0')
//   }
//
//   @Builder
//   deleteButton(index) {
//     Button('删除')
//       .backgroundColor($r('app.color.primary_light'))
//       .fontColor('#fff')
//       .width(80)
//       .height('100%')
//       .type(ButtonType.Normal)
//       .onClick(() => {
//         AVPlayerClass.remove(index)
//       })
//   }
//
//   // 订阅事件
//   @State
//   @Watch("changeAnimate")
//   playState: PlayStateType = new PlayStateTypeModel({} as PlayStateType)
//
//   changeAnimate() {
//     this.randomColor = `rgb(${Math.floor(Math.random() * 255)},${Math.floor(Math.random() * 255)},${Math.floor(Math.random() * 255)})`
//     this.randomShakeX = 2 - Math.random() * 4
//     this.randomShakeY = 2 - Math.random() * 4
//     // this.time = setInterval(() => {
//     //   clearInterval(this.time)
//     //   this.rotateAngle = this.rotateAngle + 1
//     // }, 1000)
//   }
//
//   async aboutToAppear() {
//     emitter.on({ eventId: EmitEvenType.UPDATE_STATE }, (data) => {
//       this.playState = new PlayStateTypeModel(JSON.parse(data.data.playState))
//     })
//     //从首选项中获取数据
//     const preferences: PreferencesClass = new PreferencesClass(getContext())
//     this.playState = await preferences.getPlayState()
//   }
//
//
//   build() {
//     Stack({ alignContent: Alignment.Bottom }) {
//       // 播放
//       Stack() {
//         // 变色背景
//         Image(this.playState.img)
//           .width('100%')
//           .height('100%')
//           .blur(1000)
//         // 内容
//         Column() {
//           // //   播放界面
//           Column() {
//             // 图片
//             Stack({ alignContent: Alignment.Top }) {
//               Row() {
//                 Row() {
//                   Image(this.playState.img)
//                     .width('70%')
//                     .borderRadius(400)
//                 }
//                 .backgroundImage($r('app.media.ic_cd'))
//                 .backgroundImageSize(ImageSize.Cover)
//                 .justifyContent(FlexAlign.Center)
//                 .width('100%')
//                 .borderRadius(400)
//                 .clip(true)
//                 .aspectRatio(1)
//                 .shadow({
//                   radius: 50,
//                   color: this.randomColor
//                 })
//                 .rotate({ angle: this.rotateAngle }) //旋转
//                 .animation({
//                   duration: 1200,
//                   curve: Curve.Friction,
//                   delay: 500,
//                   iterations: -1, // 设置-1表示动画无限循环
//                   playMode: PlayMode.Alternate
//                 })
//               }
//               .margin({
//                 top: 50
//               })
//               .width('90%')
//               .aspectRatio(1)
//               .justifyContent(FlexAlign.Center)
//               .padding(24)
//               // 唱针
//               Image($r('app.media.ic_stylus'))
//                 .width(200)
//                 .aspectRatio(1)
//                 .rotate({
//                   angle: this.playState.isPlay ? -45 : -55,
//                   centerX: 100,
//                   centerY: 30
//                 })
//                 .animation({
//                   duration: 500
//                 })
//             }
//             // 歌曲信息
//             Stack() {
//               //第一个
//               Column({ space: 8 }) {
//                 Text(this.playState.name)
//                   .fontSize(28)
//                   .fontWeight(FontWeight.Bold)
//                   .fontColor($r('app.color.primary_dark'))
//                 Text(this.playState.author)
//                   .fontSize(18)
//                   .fontColor($r('app.color.primary_dark'))
//               }
//               .layoutWeight(1)
//               .justifyContent(FlexAlign.Center)
//               .zIndex(1)
//               .translate({
//                 x: this.randomShakeX,
//                 y: this.randomShakeY
//               })
//
//               //第二个
//               Column({ space: 8 }) {
//                 Text(this.playState.name)
//                   .fontSize(28)
//                   .fontWeight(FontWeight.Bold)
//                   .fontColor($r('app.color.primary_light'))
//                 Text(this.playState.author)
//                   .fontSize(18)
//                   .fontColor($r('app.color.primary_light'))
//               }
//               .layoutWeight(1)
//               .justifyContent(FlexAlign.Center)
//               .zIndex(2)
//               .translate({
//                 x: this.randomShakeY,
//                 y: this.randomShakeX
//               })
//               //第三个
//               Column({ space: 8 }) {
//                 Text(this.playState.name)
//                   .fontSize(28)
//                   .fontWeight(FontWeight.Bold)
//                   .fontColor(Color.White)
//                 Text(this.playState.author)
//                   .fontSize(18)
//                   .fontColor(Color.White)
//               }
//               .layoutWeight(1)
//               .justifyContent(FlexAlign.Center)
//               .zIndex(3)
//               .translate({
//                 x: this.randomShakeX,
//                 y: this.randomShakeY
//               })
//             }
//             .layoutWeight(1)
//             // 操作
//             Row() {
//               Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC' } }) {
//                 Image($r("app.media.ic_like"))
//                   .fillColor(Color.White)
//                   .width(24)
//               }
//
//               Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc' } }) {
//                 Image($r("app.media.ic_comment_o"))
//                   .fillColor(Color.White)
//                   .width(18)
//               }
//
//               Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131' } }) {
//                 Image($r("app.media.ic_bells_o"))
//                   .fillColor(Color.White)
//                   .width(24)
//               }
//
//               Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371' } }) {
//                 Image($r("app.media.ic_download_o"))
//                   .fillColor(Color.White)
//                   .width(24)
//               }
//             }
//             .width('100%')
//             .justifyContent(FlexAlign.SpaceAround)
//             // 播放
//             Column() {
//               // 进度条
//               Row({ space: 4 }) {
//                 Text(this.number2time(this.playState.time))
//                   .fontSize(12)
//                   .fontColor(Color.White)
//                 Slider({
//                   value: this.playState.time,
//                   min: 0,
//                   max: this.playState.duration
//                 })
//                   .layoutWeight(1)
//                   .blockColor(Color.White)
//                   .selectedColor(Color.White)
//                   .trackColor('#ccc5c5c5')
//                   .trackThickness(2)
//                   .onChange((value) => {
//                     AVPlayerClass.player.seek(value)
//                   })
//                 Text(this.number2time(this.playState.duration))
//                   .fontSize(12)
//                   .fontColor(Color.White)
//               }
//               .width('100%')
//               .padding(24)
//               // 切换
//               Row() {
//                 if (this.playState.playMode === 'auto') {
//                   Image($r("app.media.ic_auto"))
//                     .fillColor(Color.White)
//                     .width(30)
//                     .onClick(() => {
//                       AVPlayerClass.changeModel('repeat')
//                     })
//
//                 } else if (this.playState.playMode === 'repeat') {
//                   Image($r("app.media.ic_auto"))
//                     .fillColor(Color.White)
//                     .width(30)
//                     .onClick(() => {
//                       AVPlayerClass.changeModel('random')
//                     })
//                 } else if (this.playState.playMode === 'random') {
//                   Image($r("app.media.ic_random"))
//                     .fillColor(Color.White)
//                     .width(30)
//                     .onClick(() => {
//                       AVPlayerClass.changeModel('auto')
//                     })
//                 }
//
//                 Image($r('app.media.ic_prev'))
//                   .fillColor(Color.White)
//                   .width(30)
//                   .onClick(() => {
//                     AVPlayerClass.previous()
//                   })
//
//                 // 播放按钮
//                 Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
//                   .fillColor(Color.White)
//                   .width(50)
//                   .onClick(() => {
//                     this.playState.isPlay ? AVPlayerClass.pause() : AVPlayerClass.singlePlay(this.playState.playList[this.playState.playIndex])
//                   })
//                 // 下一首
//                 Image($r('app.media.ic_next'))
//                   .fillColor(Color.White)
//                   .width(30)
//                   .onClick(() => {
//                     AVPlayerClass.next()
//                   })
//                 // 播放列表
//                 Image($r('app.media.ic_song_list'))
//                   .fillColor(Color.White)
//                   .width(30)
//                   .onClick(() => {
//                     this.panelHeight = '100%'
//                   })
//               }
//               .width('100%')
//               .padding({
//                 bottom: 24
//               })
//               .justifyContent(FlexAlign.SpaceAround)
//             }
//             .width('100%')
//           }
//           .layoutWeight(1)
//           .width('100%')
//         }
//       }
//       .backgroundColor(Color.Transparent)
//       // 列表
//       Column() {
//         Column() {
//
//         }
//         .width('100%')
//         .layoutWeight(1)
//         .onClick(() => {
//           this.panelHeight = '0%'
//         })
//
//         Column() {
//           Row() {
//             Row() {
//               Image($r("app.media.ic_play"))
//                 .width(20)
//                 .fillColor('#ff5186')
//             }
//             .width(50)
//             .aspectRatio(1)
//             .justifyContent(FlexAlign.Center)
//
//             Row({ space: 8 }) {
//               Text(`播放列表 (${this.playState.playList?.length})`)
//                 .fontColor(Color.White)
//                 .fontSize(14)
//             }
//             .layoutWeight(1)
//
//             Image($r('app.media.ic_close'))
//               .fillColor('#ffa49a9a')
//               .width(24)
//               .height(24)
//               .margin({ right: 16 })
//               .onClick(() => {
//                 this.panelHeight = '0%'
//               })
//           }
//           .width('100%')
//           .backgroundColor('#ff353333')
//           .padding(8)
//           .border({
//             width: { bottom: 1 },
//             color: '#12ec5c87'
//           })
//           .borderRadius({
//             topLeft: 4,
//             topRight: 4
//           })
//           // 播放列表
//           List() {
//             ForEach(this.playState.playList, (item: songItemType, index: number) => {
//               ListItem() {
//                 Row() {
//                   Row() {
//                     Text((index + 1).toString())
//                       .fontColor('#ffa49a9a')
//                   }
//                   .width(50)
//                   .aspectRatio(1)
//                   .justifyContent(FlexAlign.Center)
//                   // 列表
//                   Row({ space: 10 }) {
//                     Column() {
//                       Text(item.name)
//                         .fontSize(14)
//                         .fontColor(this.playState.playIndex === index ? $r('app.color.primary_light') : '#ffa49a9a')
//                       Text(item.author)
//                         .fontSize(12)
//                         .fontColor(this.playState.playIndex === index ? $r('app.color.primary_light') : Color.Gray)
//                     }
//                     .layoutWeight(1)
//                     .alignItems(HorizontalAlign.Start)
//                     .justifyContent(FlexAlign.Center)
//                   }
//                   .layoutWeight(1)
//
//                   Image($r('app.media.ic_more'))
//                     .width(24)
//                     .height(24)
//                     .margin({ right: 16 })
//                     .fillColor(Color.Gray)
//                 }
//                 .alignItems(VerticalAlign.Center)
//               }
//               .onClick(() => {
//                 AVPlayerClass.singlePlay(item)
//               })
//               .swipeAction({
//                 end: this.deleteButton(index)
//               })
//               .border({
//                 width: { bottom: 1 },
//                 color: '#12ec5c87'
//               })
//             })
//           }
//           .layoutWeight(1)
//           .backgroundColor('#ff353333')
//
//         }
//         .height(400)
//       }
//       .height(this.panelHeight)
//       .animation({
//         duration: 300
//       })
//
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor(Color.Transparent)
//     .opacity(this.opacityNum)
//   }
//   // 页面也换效果,避免滑动切换效果
//   pageTransition() {
//     PageTransitionEnter({ duration: 200 })
//       .onEnter(() => {
//         this.opacityNum = 1
//       })
//     PageTransitionExit({ duration: 200 })
//       .onExit(() => {
//         this.opacityNum = 0
//       })
//   }
// }
import { songItemType } from '../models/music'
@Entry
@Component
struct Play {
  songs: songItemType[] = [
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg',
      name: '直到世界的尽头',
      author: 'WANDS',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a',
      id: '0000'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.jpg',
      name: '画',
      author: '赵磊',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.mp3',
      id: '0001'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.jpg',
      name: 'Sweet Dreams',
      author: 'TPaul Sax / Eurythmics',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.mp3',
      id: '0002'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.jpg',
      name: '奢香夫人',
      author: '凤凰传奇',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.m4a',
      id: '0003'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.jpg',
      name: '空心',
      author: '光泽',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.mp3',
      id: '0004'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.jpg',
      name: '反转地球',
      author: '潘玮柏',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.mp3',
      id: '0005'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.jpg',
      name: 'No.9',
      author: 'T-ara',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.m4a',
      id: '0006'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.jpg',
      name: '孤独',
      author: 'G.E.M.邓紫棋',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.m4a',
      id: '0007'
    },

    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.jpg',
      name: 'Lose Control',
      author: 'Hedley',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.m4a',
      id: '0008'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.jpg',
      name: '倩女幽魂',
      author: '张国荣',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.m4a',
      id: '0009'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.jpg',
      name: '北京北京',
      author: '汪峰',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.m4a',
      id: '0010'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.jpg',
      name: '苦笑',
      author: '汪苏泷',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.mp3',
      id: '0011'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.jpg',
      name: '一生所爱',
      author: '卢冠廷 / 莫文蔚',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.m4a',
      id: '0012'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.jpg',
      name: '月半小夜曲',
      author: '李克勤',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.mp3',
      id: '0013'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.jpg',
      name: 'Rolling in the Deep',
      author: 'Adele',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.m4a',
      id: '0014'
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.jpg',
      name: '海阔天空',
      author: 'Beyond',
      url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.m4a',
      id: '0015'
    }
  ]
  // 当前播放的歌曲
  @State
  playSong:songItemType = this.songs[0]
  aboutToAppear(){
  const index = router.getParams()['indexKey']
    this.playSong = this.songs[index]
  }
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 播放
      Stack() {
        // 变色背景
        Image(this.playSong.img)
          .width('100%')
          .height('100%')
          .blur(1000)
        // 内容
        Column() {
          // //   播放界面
          Column() {
            // 图片
            Stack({ alignContent: Alignment.Top }) {
              Row() {
                Row() {
                  Image(this.playSong.img)
                    .width('70%')
                    .borderRadius(400)
                }
                .backgroundImage($r('app.media.ic_cd'))
                .backgroundImageSize(ImageSize.Cover)
                .justifyContent(FlexAlign.Center)
                .width('100%')
                .borderRadius(400)
                .clip(true)
                .aspectRatio(1)
              }
              .margin({
                top: 50
              })
              .width('90%')
              .aspectRatio(1)
              .justifyContent(FlexAlign.Center)
              .padding(24)
              // 唱针
              Image($r('app.media.ic_stylus'))
                .width(200)
                .aspectRatio(1)
                .rotate({
                  angle: -55,
                  centerX: 100,
                  centerY: 30
                })
                .animation({
                  duration: 500
                })
            }
            // 歌曲信息
            Stack() {
              // 第一个
              Column({ space: 8 }) {
                Text(this.playSong.name)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4bb0c4')
                Text(this.playSong.author)
                  .fontSize(18)
                  .fontColor('#4bb0c4')
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .zIndex(1)
              // 第二个
              Column({ space: 8 }) {
                Text(this.playSong.name)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#ec5c87')
                Text(this.playSong.author)
                  .fontSize(18)
                  .fontColor('#ec5c87')
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .zIndex(2)
              // 第三个
              Column({ space: 8 }) {
                Text(this.playSong.name)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                Text(this.playSong.author)
                  .fontSize(18)
                  .fontColor(Color.White)
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .zIndex(3)
            }
            .layoutWeight(1)
            // 操作
            Row() {
              Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC' } }) {
                Image($r("app.media.ic_like"))
                  .fillColor(Color.White)
                  .width(24)
              }

              Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc' } }) {
                Image($r("app.media.ic_comment_o"))
                  .fillColor(Color.White)
                  .width(18)
              }

              Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131' } }) {
                Image($r("app.media.ic_bells_o"))
                  .fillColor(Color.White)
                  .width(24)
              }

              Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371' } }) {
                Image($r("app.media.ic_download_o"))
                  .fillColor(Color.White)
                  .width(24)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceAround)
            // 播放
            Column() {
              // 进度条
              Row({ space: 4 }) {
                Text('00:00')
                  .fontSize(12)
                  .fontColor(Color.White)
                Slider({
                  value: 0,
                  min: 0,
                  max: 0
                })
                  .layoutWeight(1)
                  .blockColor(Color.White)
                  .selectedColor(Color.White)
                  .trackColor('#ccc5c5c5')
                  .trackThickness(2)
                Text('00:00')
                  .fontSize(12)
                  .fontColor(Color.White)
              }
              .width('100%')
              .padding(24)
              // 切换
              Row() {
                Image($r("app.media.repeat"))
                  .fillColor(Color.White)
                  .width(30)

                Image($r("app.media.ic_prev"))
                  .fillColor(Color.White)
                  .width(30)

                // 播放按钮
                Image($r('app.media.ic_play'))
                  .fillColor(Color.White)
                  .width(50)
                // 下一首
                Image($r('app.media.ic_next'))
                  .fillColor(Color.White)
                  .width(30)
                // 播放列表
                Image($r('app.media.ic_song_list'))
                  .fillColor(Color.White)
                  .width(30)
              }
              .width('100%')
              .padding({
                bottom: 24
              })
              .justifyContent(FlexAlign.SpaceAround)
            }
            .width('100%')
          }
          .layoutWeight(1)
          .width('100%')
        }
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }
}