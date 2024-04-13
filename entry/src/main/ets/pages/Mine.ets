import { songs } from '../constants/musicsj'
import { songItemType, songItemTypeModel } from '../models/music'

@Component
struct Mine {
  columnList: number[] = [0, 1, 2, 3]
  build() {
    Column() {
      // 背景
      Column() {
        GridRow({ gutter: 8 }) {
          ForEach(this.columnList, item => {
            GridCol({ span: 3 }) {
              SongCard({columnIndex: item })
            }
          })
        }
      }
      .scale({
        x: 1.15,
        y: 1.15,
        centerX: '50%',
        centerY: '0'

      })
      .height('75%')
      .width('100%')
      .backgroundColor('#000')
      // 个人信息
      Column() {
        Column() {
          Image($r('app.media.tx'))
            .width('90%')
        }
        .backgroundColor(Color.Black)
        .width(80)
        .aspectRatio(1)
        .borderRadius(80)
        .offset({ y: -40 })

        Column({ space: 12 }) {
          Row({ space: 8 }) {
            Text('Wale')
              .fontColor(Color.White)
              .fontSize(20)
            Image($r('app.media.ic_vip'))
              .width(40)
          }
          .offset({ y: -15 })

          Row() {
            Image($r('app.media.ic_boy'))
              .width(14)
              .fillColor('#ff23496b')
              .margin({ right: 4 })
            Text('00后')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('双子座')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('河南')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('歌龄·18年')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
          }

          Row() {
            Text('1 关注')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('100万 粉丝')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('1.67亿 赞')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
          }
        }
      }
      .width('100%')
      .height('25%')
      .backgroundColor('#121215')
    }
    .width('100%')
  }
}

@Component
struct SongCard {
  columnIndex: number
  @State
  showList: songItemType[] = []
  aboutToAppear() {
    this.showList = songs.map(item => new songItemTypeModel(item))
      .sort(() => Math.random() - 0.5)
  }
  build() {
    List({ space: 12 }) {
      ForEach(this.showList, (item: songItemType) => {
        ListItem() {
          Stack() {
            Image(item.img)
              .width('100%')
            // 播放中动图
            Row() {
              Image($r('app.media.ic_play'))
                .width('50%')
            }
            .backgroundColor('#7a000000')
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .visibility(Visibility.Hidden)
          }
          .width('100%')
          .aspectRatio(1)
          .borderRadius(8)
          .clip(true)
        }
      })
    }
    .width('100%')
  }
}

export default Mine