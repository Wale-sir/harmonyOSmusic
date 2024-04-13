import { TabClass } from '../models/music'
import { tabsData } from '../constants/musicsj'
import Find from './Find'
import Mine from './Mine'
import Moment from './Moment'
import Recommend from './Recommend'
import SongList from './SongList'
import router from '@ohos.router'
// import PlayerNav from '../components/playerNav'
import emitter from '@ohos.events.emitter'
import { EmitEvenType } from '../constants/EventConstants'
import { PlayStateType, PlayStateTypeModel } from '../models/playState'

@Entry
@Component
struct HomeIndex {
  @State
  currentName: string = 'recommend'
  @State
  opacityNum: number = 1
  // tabBar组件
  @Builder
  getTabBar(item: TabClass) {
    Column() {
      Row() {
        Image(item.icon)
          .fillColor(item.name === this.currentName ? Color.White : $r('app.color.primary_dark'))
          .width(item.name === this.currentName ? 18 : 22)
          .aspectRatio(1)
      }
      .width(22)
      .aspectRatio(1)
      .borderRadius(22)
      .backgroundColor(item.name === this.currentName ? $r('app.color.primary_light') : Color.Transparent)
      .justifyContent(FlexAlign.Center)

      Text(item.title)
        .fontSize(12)
        .fontWeight(400)
        .margin({ top: 5 })
        .fontColor(item.name === this.currentName ? $r('app.color.primary_light') : $r('app.color.primary_dark'))
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  // // 订阅事件
  // @State
  // playState: PlayStateType = new PlayStateTypeModel({} as PlayStateType)
  //
  // aboutToAppear() {
  //   emitter.on({ eventId: EmitEvenType.UPDATE_STATE }, (data) => {
  //     this.playState = new PlayStateTypeModel(JSON.parse(data.data.playStateStr))
  //   })
  // }

  build() {
    Stack() {
      Stack({ alignContent: Alignment.Bottom }) {
        Tabs({ barPosition: BarPosition.End }) {
          ForEach(tabsData, (item: TabClass) => {
            TabContent() {
              if (item.name === 'recommend') {
                Recommend()
              } else if (item.name === 'find') {
                Find()
              } else if (item.name === 'moment') {
                Moment()
              } else if (item.name === 'mine') {
                Mine()
              } else {
                SongList()
              }
            }
            .tabBar(this.getTabBar(item))
            .backgroundColor('#121215')
          })
        }
        .barHeight(60)
        .onChange(index => {
          this.currentName = tabsData[index].name
        })
        // 背景播放
        // if(this.currentName!=='mine'){
        //   PlayerNav({ playState: $playState })
        //     .translate({ y: -60 })
        //     .onClick(() => {
        //       router.pushUrl({
        //         url: 'pages/Play'
        //       })
        //     })
        // }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#3c3f41')
    .opacity(this.opacityNum)
  }
  // 页面也换效果,避免滑动切换效果
  pageTransition() {
    PageTransitionEnter({ duration: 200 })
      .onEnter(() => {
        this.opacityNum = 1
      })
    PageTransitionExit({ duration: 200 })
      .onExit(() => {
        this.opacityNum = 0
      })
  }
}


