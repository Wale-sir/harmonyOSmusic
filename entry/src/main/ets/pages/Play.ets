import router from '@ohos.router'
import emitter from '@ohos.events.emitter'
import Animator, { AnimatorOptions } from '@ohos.animator'
import AVPlayerClass  from '../untils/AVPlayerClass'
import { songs } from '../constants/musicsj'
interface playStateType {
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

interface songItemType {
  img: string
  name: string
  author: string
  url: string
  id: string
}

class PlayStateTypeModel implements playStateType {
  img: string = ''
  name: string = ''
  author: string = ''
  url: string = ''
  playIndex: number = 0
  time: number = 0
  duration: number = 0
  isPlay: boolean = false
  playMode: 'auto' | 'repeat' | 'random' = 'auto'
  playList: songItemType[] = []

  constructor(model: playStateType) {
    this.img = model.img
    this.name = model.name
    this.author = model.author
    this.url = model.url
    this.playIndex = model.playIndex
    this.time = model.time
    this.duration = model.duration
    this.isPlay = model.isPlay
    this.playMode = model.playMode
    this.playList = model.playList
  }
}

@Entry
@Component
struct Play {
  @State randomColor: string = 'rgb(0,0,0)'
  @State randomNum: number = 50
  @State shakenX: number = 0
  @State shakenY: number = 0
  @State panelHeight:string = '0%'
  // 动画配置参数
  animationOption: AnimatorOptions = {
    duration:20*1000,
    easing:'linear',
    delay:0,
    fill:'none',
    direction: 'normal',
    iterations:-1,
    begin:0,
    end:360
  }
  animator = null
  @State
  rotateAngle: number = 0
  @State
  playState: playStateType = new PlayStateTypeModel({} as playStateType)

  aboutToAppear() {

    // const index = router.getParams()['index']
    // this.playSong = this.songs[index]
    emitter.on({
      eventId: 0
    }, (data) => {
      // console.log('logData', JSON.stringify(data.data))
      this.playState = new PlayStateTypeModel(JSON.parse(data.data.data))
    //   生成颜色随机数
      this.randomColor = 'rgb('+ Math.floor(Math.random()*256)+', '+ Math.floor(Math.random()*256)+', '+ Math.floor(Math.random()*256)+')'
      this.shakenX = 2 - Math.random()*4
      this.shakenY = 2 - Math.random()*4
      if (this.playState.isPlay) {
        this.animator.play()
      }else {
        this.animator.pause()
        this.randomColor = 'rgb(0, 0, 0)'
        this.shakenX = 0
        this.shakenY = 0
      }

    })
    this.animator = Animator.create(this.animationOption)
    this.animator.onframe = (val) => {
      this.rotateAngle = val
    }

  }

  number2time(number: number) {
    const ms: number = number % 1000
    const second = (number - ms) / 1000
    const s: number = second % 60
    if (second > 60) {
      const m: number = (second - s) / 60 % 60
      return m.toString()
        .padStart(2, '0') + ':' + s.toString()
        .padStart(2, '0')
    }
    return '00:' + s.toString()
      .padStart(2, '0')
  }
  // songs: songItemType[]=songs
  songs: songItemType[] = [
    {
      img: 'http://p1.music.126.net/CfTiq9PTU7wNBKc_xRQFKA==/109951167835107568.jpg?param=130y130',
      name: '小宇',
      author: '周俐言',
      url: 'https://music.163.com/song/media/outer/url?id=1404597072.mp3',
      id: '0000'
    },
    {
      img: 'http://p2.music.126.net/STWQpRLgUBOcXQIDPoEL_A==/109951163533011733.jpg?param=130y130',
      name: '蒲公英的约定',
      author: '周杰伦',
      url: 'http://waletools.tech:8080/music/zjl.mp3',
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
  // @State
  // playSong:songItemType = this.songs[0]
  build() {

    Stack() {
      Stack({alignContent:Alignment.Bottom}) {
        // 变色背景
        Image(this.playState.img)
          .width('100%')
          .height('100%')
          .blur(1000)
        // 内容
        Column() {
          //  播放界面
          Column() {
            //   图片
            Stack({ alignContent: Alignment.Top }) {
              Row() {
                Row() {
                  Image(this.playState.img)
                    .width('70%')
                    .borderRadius(400)
                }
                .rotate({
                  angle:this.rotateAngle
                })
                .shadow({
                  radius: this.randomNum,
                  color: this.randomColor
                })
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
                  // 旋转
                .rotate({
                  angle: this.playState.isPlay?-45:-55,
                  centerX: 100,
                  centerY: 30
                })
                  // 动画
                .animation({
                  duration: 500
                })

            }
            // 歌曲信息
            Stack() {
              // 第一个
              Column({ space: 8 }) {
                Text(this.playState.name)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#4bb0c4')
                Text(this.playState.author)
                  .fontSize(18)
                  .fontColor('#4bb0c4')
              }
              .translate({
                x: this.shakenX,
                y:this.shakenY
              })
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .zIndex(1)
              // 第二个
              Column({ space: 8 }) {
                Text(this.playState.name)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#ec5c87')
                Text(this.playState.author)
                  .fontSize(18)
                  .fontColor('#ec5c87')
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .zIndex(2)
              // 第三个
              Column({ space: 8 }) {
                Text(this.playState.name)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                Text(this.playState.author)
                  .fontSize(18)
                  .fontColor(Color.White)
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .zIndex(3)
              .translate({
                x: this.shakenY,
                y:this.shakenX
              })
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
                Text(this.number2time(this.playState.time))
                  .fontSize(12)
                  .fontColor(Color.White)
                // 滑块
                Slider({
                  value: this.playState.time,
                  min: 0,
                  max: this.playState.duration
                })
                  .onChange((value) => {
                    AVPlayerClass.player.seek(value)
                  })
                  .layoutWeight(1)
                  .blockColor(Color.White)
                  .selectedColor(Color.White)
                  .trackColor('#ccc5c5c5')
                  .trackThickness(2)
                Text(this.number2time(this.playState.duration))
                  .fontSize(12)
                  .fontColor(Color.White)
              }
              .width('100%')
              .padding(24)
              // 切换
              Row() {
                // Image($r('app.media.ic_auto'))
                //   .fillColor(Color.White)
                //   .width(30)
                if (this.playState.playMode === 'auto') {
                  Image($r("app.media.auto"))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(()=>{
                      AVPlayerClass.changeMode('repeat')
                    })
                } else if (this.playState.playMode === 'repeat') {
                  Image($r("app.media.repeat"))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(()=>{
                      AVPlayerClass.changeMode('random')
                    })
                } else if (this.playState.playMode === 'random') {
                  Image($r('app.media.ic_random'))
                    .fillColor(Color.White)
                    .width(30)
                    .onClick(()=>{
                      AVPlayerClass.changeMode('auto')
                    })
                }
                // 上一首
                Image($r("app.media.ic_prev"))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(()=>{
                    AVPlayerClass.prev()
                  })

                // 播放按钮
                Image(this.playState.isPlay ? $r('app.media.zt') : $r('app.media.ic_play'))
                  .onClick(() => {
                   if (this.playState.isPlay) {

                     AVPlayerClass.pause()
                   }else {
                     AVPlayerClass.singlePlay(this.playState.playList[this.playState.playIndex])
                   }

                  }
                  )
                  .fillColor(Color.White)
                  .width(50)
                // 下一首
                Image($r('app.media.ic_next'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(()=>{
                    AVPlayerClass.next()
                  })
                // 播放列表
                Image($r('app.media.ic_song_list'))
                  .fillColor(Color.White)
                  .width(30)
                  .onClick(() =>{
                    this.panelHeight = '50%'
                  })
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
        .onClick(() => {
          this.panelHeight = '0%'
        })
        // 列表
        Column() {
          Column() {

          }
          .width('100%')
          .layoutWeight(1)
          .onClick(() => {
            this.panelHeight = '0%'
          })
          Column() {
            Row({space: 10}) {
              Image($r('app.media.ic_play'))
                .width(20)
                .aspectRatio(1)
              Text('播放列表')
                .fontColor('white')
              Text(`(${this.playState.playList?.length})`)
                .fontColor('white')
            }
            .width('100%')
            // 列表
            List() {
              ForEach(this.playState.playList, (item:songItemType, index) => {
                ListItem() {
                  Row({space:10}) {
                    Text(String(index+1))
                      .fontColor('rgb(99, 97, 98)')
                      Column() {
                        Text(item.name)
                          .fontColor(this.playState.playIndex === index?'rgb(254, 81, 134)':'rgb(99, 97, 98)')
                        Text(item.author)
                          .fontColor(this.playState.playIndex === index?'rgb(254, 81, 134)':'rgb(99, 97, 98)')
                      }
                      .onClick(() => {
                        AVPlayerClass.singlePlay(item)
                      })
                      .alignItems(HorizontalAlign.Start)
                      .layoutWeight(1)



                    Image($r('app.media.ic_more'))
                      .width(20)
                      .fillColor('rgb(99, 97, 98)')
                  }
                  .width('100%')
                  .height(60)

                }

              })
            }
          }
          .padding(20)
          .backgroundColor('rgb(53, 51, 52)')
          .width('100%')

        }
        .height(this.panelHeight)
        .animation({
          duration:300
        })


      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }
}