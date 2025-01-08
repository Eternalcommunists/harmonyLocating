import router from '@ohos.router'
@Component
export struct Header{
  build(){
    //   标题部分
    Row({space:5}){
      Image($r('app.media.fanhui'))
        .width(20)
        .onClick(() =>{
          router.back()
        })
      Blank()
      Image($r('app.media.shuaxin'))
        .width(30)
    }
    .width('98%')
    .height(30)
  }
}