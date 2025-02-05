import { MapComponent, mapCommon, map } from '@kit.MapKit';
import http from '@ohos.net.http';

// 1. 定义丢失物品的类型
interface LostItem {
  latitude: number;
  longitude: number;
  name: string;
  description: string;
  image: string;
}

@Entry
@Component
struct LostItemMap {
  private mapOption?: mapCommon.MapOptions;
  private mapController?: map.MapComponentController;
  private lostItems: LostItem[] = []; // 2. 使用明确的类型
  private selectedItem?: LostItem;  // 选中的物品

  aboutToAppear(): void {
    this.mapOption = {
      position: { target: { latitude: 39.9, longitude: 116.4 }, zoom: 10 }
    };
    this.fetchLostItems();
  }

  fetchLostItems(): void {
    let httpRequest = http.createHttp();
    httpRequest.request(
      'https://api.example.com/lost-items',
      {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' }
      },
      (err: Error | null, data: http.HttpResponse): void => { // 3. 明确类型
        if (err) {
          console.error('数据请求失败:', err.message);
          return;
        }
        try {
          let response: { items: LostItem[] } = JSON.parse(data.result); // 解析 JSON
          this.lostItems = response.items;
        } catch (parseError) {
          console.error('解析数据失败:', (parseError as Error).message);
        }
      }
    );
  }

  build() {
    Stack() {
      MapComponent({ mapOptions: this.mapOption, mapCallback: (err: Error | null, controller?: map.MapComponentController) => {
        if (!err && controller) this.mapController = controller;
      }})
        .width('100%')
        .height('100%');

      ForEach(this.lostItems, (item: LostItem) => {
        map.Marker({
          position: { latitude: item.latitude, longitude: item.longitude },
          icon: { uri: 'path/to/green-dot.png', width: 30, height: 30 }
        }).onClick(() => {
          this.selectedItem = item;
        });
      });

      If(this.selectedItem, () => {
        Column()
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(10)
          .position({ align: Alignment.Bottom })
          .width('80%')
          .height(200)
          .create(() => {
            Text(this.selectedItem?.name).fontSize(18).fontWeight(FontWeight.Bold);
            Text(this.selectedItem?.description).fontSize(14).margin({ top: 5 });
            Image(this.selectedItem?.image).width('100%').height(100).margin({ top: 10 });
          });
      });
    }.height('100%');
  }
}
