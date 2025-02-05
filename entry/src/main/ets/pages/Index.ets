import axios, { AxiosResponse } from '@ohos/axios';
import router from '@ohos.router';
//@HMRouter({pageUrl: 'Index'})
//import deveco.db as db;
interface FindResponse {
  success: boolean; // 请求是否成功
  message: string;  // 响应消息
  data: string;        // 具体的业务数据（可以根据实际情况修改为更具体的类型）
}
@Entry
@Component


struct Index {

  @State zhanghao: string = ''
  @State mima: string = ''
  @State zhanghao_find:string =''
  @State mima_find:string =''


  build() {
    Column({space:10}) {
      Image($r("app.media.img"))
        .width(80)
        .height(80)
        .borderRadius(50)
        .margin({
          top:"120vp"
        })
      Text("欢迎登录")
        .padding({
          top:'5vp',
          bottom:'5vp'
        })
        .fontColor(Color.Gray)
        .fontSize(14)
        .margin({
          top:'25vp'
        })
      TextInput({placeholder:'请输入用户名'})
        .margin({bottom:'10vp'}).fontColor(Color.Black).onChange(value =>{
        console.log(value)
        this.zhanghao_find=value
      })
      TextInput({placeholder:'请输入密码'}).onChange(value =>{
        console.log(value)
        this.mima_find=value
      })
        .margin({bottom:'10vp'}).fontColor(Color.Black)
      Row() {
        Button("短信验证码登录").backgroundColor(Color.White)
          .fontColor(Color.Black)
          .fontSize(14)
          .margin({
            left:'5vp'
          })
        Button('忘记密码').backgroundColor(Color.White)
          .fontColor(Color.Black)
          .fontSize(14)
          .onClick(() => {
            router.pushUrl({url:'pages/WangjiMima'})
          })
        }
      .padding({
        top:'10vp',
        bottom:'10vp'
      })
      .width("100%").justifyContent(FlexAlign.SpaceBetween)

      Button("登录").width("100%").type(ButtonType.Capsule).onClick(async () => {
        try {
          // 使用 AxiosResponse<FindResponse> 来明确 res 的类型
          const res: AxiosResponse<FindResponse> = await axios({
            method: "get",
            url: `http://localhost:3000/find/${this.zhanghao_find}/${this.mima_find}`,
          });

          console.info('result:', JSON.stringify(res.data));

          // 判断是否登录成功
          if (res.data.success) {
            router.pushUrl({
              url: 'pages/NewApp_one',
            });
          } else {
            console.error('登录失败:', res.data.message);
          }
        } catch (error) {
          // 错误处理
          console.error('请求错误:', error);
        }
      });
      //Button("登录").width("100%").type(ButtonType.Capsule);
      Button("注册账号").backgroundColor(Color.White).fontColor(Color.Blue).fontSize(14).onClick( () => {
        {
          router.pushUrl({url: 'pages/zhuce'})
        }
      })
        LoadingProgress().width(50).height(50).color(Color.Blue)
      Blank()
      Row(){
        Line().width("20%").height(0.5)
          .backgroundColor(Color.Gray)
        Text("其他登录方式")
          .fontSize(14).fontColor(Color.Gray)
          .margin({
            left:10,
            right:10,
            bottom:10
          })
        Line().width("20%").height(0.5)
          .backgroundColor(Color.Gray)
      }
      Row({space:50}){
        Button(){
          Image($r("app.media.wechat")).width(35).height(35)
        }.backgroundColor(Color.Transparent)
        Button(){
          Image($r("app.media.douyin")).width(35).height(35)
        }.backgroundColor(Color.Transparent)
        Button(){
          Image($r("app.media.weibo")).width(35).height(35)
        }.backgroundColor(Color.Transparent)//引入图片长宽背景设置为透明
      }.width("75%").justifyContent(FlexAlign.SpaceAround).margin({
        bottom:10
      })
    }
    //.backgroundImage($r("app.media.background1"))
    .backgroundImageSize({
      height:'100%'
    })
    //.backgroundImagePosition()
    .padding({
      left:'10vp',
      right:'10vp',
      bottom:'10vp'
    })
    //.border({ width: 1 })
    .width("100%")
    .height("100%")
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}