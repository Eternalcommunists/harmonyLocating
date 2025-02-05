import { Header } from '../components/Toubu'
import axios, { AxiosResponse } from '@ohos/axios'
import router from '@ohos.router'

interface RegisterResponse {
  success: boolean; // 注册是否成功
  message: string; // 结果说明消息
}
// 定义一个接口，描述注册请求的参数

interface RegisterRequestData {
  zhanghao: string;
  mima: string;
}
@Entry
@Component
struct Index {
  @State zhanghao: string = ''
  @State mima: string = ''

  build() {
    Column() {
      Header().margin({ top: 20, bottom: 20 })

      // 账号输入框
      TextInput({placeholder:'请输入用户名'})
        .margin({bottom:'10vp'}).fontColor(Color.Black).onChange(value =>{
        console.log(value)
        this.zhanghao=value
      })
        .margin({ left: 20, right: 20, bottom: 10 })
        .height(50)
        .backgroundColor('#36D2')

      // 密码输入框
      TextInput({placeholder:'请输入密码'})
        .margin({bottom:'10vp'}).fontColor(Color.Black).onChange(value =>{
        console.log(value)
        this.mima=value
      })
        .margin({ left: 20, right: 20, bottom: 20 })
        .height(50)
        .backgroundColor('#36D2')

      // 注册按钮
      Button("注册并登录")
        .width("100%")
        .type(ButtonType.Capsule)
        .onClick(async (): Promise<void> => {
          // 定义请求数据类型
          const requestData: RegisterRequestData = {
            zhanghao: this.zhanghao,
            mima: this.mima,
          };

          try {
            // 发起 POST 请求
            const response: AxiosResponse<RegisterResponse> = await axios.post(
              'http://localhost:3000/publish',
              requestData
            );

            // 根据响应的结果进行判断
            if (response.data.success) {
              console.info('注册成功，跳转页面');
              router.pushUrl({ url: 'pages/NewApp_one' });
            } else {
              console.error('注册失败:', response.data.message);
            }
          } catch (error) {
            // 捕获请求错误并打印
            console.error('注册请求失败:', error);
          }
        });
    }
    .width('100%')
    .height('100%')
  }
}