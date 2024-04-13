import router from '@ohos.router'
@Entry
@Component
struct Start {
  aboutToAppear(){
    setTimeout(()=>{
      router.replaceUrl({
        url:'pages/Index'
      })
    },3000)
  }
  build() {

    Stack({alignContent:Alignment.TopEnd}){
      Image($r('app.media.g1'))
      Button('跳过').margin(20).opacity(0.3).onClick(()=> {
        router.replaceUrl({
          url: 'pages/Index'
        })
      })
    }.width('100%').height('100%')

  }
}