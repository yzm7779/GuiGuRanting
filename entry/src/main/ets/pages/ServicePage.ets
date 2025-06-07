import { getServiceDataApi } from "../api/service";
import { IndexScroll } from "../components/ScrollContainer/IndexScroll";
import { PADDING } from "../constants/size";
import {
  ICleaningServiceInfoList,
  IHomeServiceList,
  INewComerZero,
  IServiceActivity,
  IVipServiceList
} from "../modules/ServiceData";
import rvp from "../utils/responsive";
import { Bg } from "../views/Service/Bg";
import { DomesticService } from "../views/Service/DomesticService";
import { NavBar } from "../views/Service/NavBar";
import { ServiceCalender } from "../views/Service/ServiceCalender";
import { VIP } from "../views/Service/VIP";
import { serviceNotification } from "@kit.PushKit";
import { ServiceClean } from "../views/Service/ServiceClean";

@Component
export struct ServicePage {
  @State vipServiceList: IVipServiceList = []
  @State homeServiceList: IHomeServiceList = []
  @State serviceActivity: IServiceActivity = {
    "name": '',
    "img": '',
    "title": '',
    "subTitle": ''
  }
  @State newcomerZoneImg: string = ''
  @State cleaningServiceInfo: ICleaningServiceInfoList = []
  //获取首页数据
  getServiceData = async () => {
    const serviceData = await getServiceDataApi()
    this.vipServiceList = serviceData.vipServiceList
    this.homeServiceList = serviceData.homeServiceList
    this.serviceActivity = serviceData.serviceActivity
    this.newcomerZoneImg = serviceData.newcomerZone.img
    this.cleaningServiceInfo = serviceData.cleaningServiceInfo
    console.log(JSON.stringify(this.homeServiceList))
    console.log(JSON.stringify(this.serviceActivity))
    console.log(JSON.stringify(this.newcomerZoneImg))
    console.log(JSON.stringify(this.cleaningServiceInfo))
  }

  aboutToAppear(): void {
    this.getServiceData()
  }

  @Builder
  navBuilder() {
    NavBar()
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        VIP({ vipServiceList: this.vipServiceList })
        DomesticService({ homeServiceList: this.homeServiceList })
        ServiceCalender({ serviceActivity: this.serviceActivity })
        ServiceClean({ newcomerZoneImg: this.newcomerZoneImg, cleaningServiceInfo: this.cleaningServiceInfo })
      }
      .width('100%').padding({ left: rvp(PADDING), right: rvp(PADDING) })
    }
    .width('100%').alignContent(Alignment.TopStart).backgroundColor($r('app.color.bg_gray_second'))
  }

  build() {
    IndexScroll({
      navBuilderParam: this.navBuilder,
      contentBuilderParam: () => {
        this.contentBuilder()
      }
    })
  }
}