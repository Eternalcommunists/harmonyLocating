import { Header } from '../components/Toubu'
import  axios, { AxiosResponse }  from '@ohos/axios'
import router from '@ohos.router'

interface FindResponse {
  success: boolean;  // 请求是否成功
  message: string;   // 响应消息
  data: string;      // 具体的业务数据（可以根据实际情况修改为更具体的类型）
}

interface UpdatePasswordRequest {  // 新增接口，确保请求的数据类型
  zhanghao: string;
  newmima: string;
}
@Entry
@Component

struct Index {
  // 上传数据
  @State zhanghao: string = '';
  @State mima: string = '';

  // 处理输入框变化
  handleZhanghaoChange(value: string) {
    this.zhanghao = value;
  }

  handleMimaChange(value: string) {
    this.mima = value;
  }
  handleRefresh() {
    this.zhanghao = '';
    this.mima = '';
  }

  // 提交修改密码请求
  async handleSubmit() {
    const requestData: UpdatePasswordRequest = {  // 显式声明请求数据类型
      zhanghao: this.zhanghao,
      newmima: this.mima
    };

    try {
      const response: AxiosResponse<FindResponse> = await axios({
        method: "post",
        url: 'http://localhost:3000/upd',
        data: requestData,  // 使用已声明类型的数据
      });

      console.info('result:' + JSON.stringify(response.data));

      if (response.data.success) {
        router.pushUrl({
          url: 'pages/NewApp_one',
        });
      } else {
        console.error('修改密码失败:', response.data.message);
      }
    } catch (error) {
      console.error('请求错误:', error);
    }
  }

  build() {
    Column() {
      Header()
        .margin(20);

      TextInput({ placeholder: '原账号' })
        .margin(20)
        .height(50)
        .onChange(this.handleZhanghaoChange)  // 直接调用函数
        .backgroundColor('#0000');

      TextInput({ placeholder: '新密码' })
        .margin({ left: 30, right: 30, bottom: 30 })
        .height(50)
        .onChange(this.handleMimaChange)  // 直接调用函数
        .backgroundColor('#0000');

      Button('修改密码')
        .width(200)
        .onClick(this.handleSubmit);  // 直接调用函数

      Button('刷新')
        .width(200)
        .onClick(this.handleRefresh)
        .margin({top:30,bottom:30});
    }
    .width('100%')
    .height('100%');


  }
}