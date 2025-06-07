import { IndexCard } from "../../components/Card/IndexCard";
import { IHomeServiceItem, IHomeServiceList } from "../../modules/ServiceData";
import rvp from "../../utils/responsive";
import image from "@ohos.multimedia.image";

@Component
export struct DomesticService {
  @Prop homeServiceList: IHomeServiceList

  build() {
    Column() {
      IndexCard() {
        Row() {
          Text('家庭服务')
            .fontWeight(700).fontSize(rvp(16)).lineHeight(rvp(19))
          Row({ space: 5 }) {
            Text('全部服务')
              .fontColor('#999999').fontWeight(500).fontSize(rvp(12)).lineHeight(rvp(14))
            Image($r('app.media.right_arrow'))
              .fillColor('#999999').width(rvp(4)).height(rvp(6))
          }
        }
        .width('100%')
        .padding({ top: rvp(8) })
        .justifyContent(FlexAlign.SpaceBetween)

        Grid() {
          ForEach(this.homeServiceList, (serviceItem: IHomeServiceItem) => {
            GridItem() {
              Column({ space: rvp(9) }) {
                Image(serviceItem.icon)
                  .width(rvp(24)).height(rvp(24)).objectFit(ImageFit.Fill)
                Text(serviceItem.title)
                  .fontSize(rvp(12)).lineHeight(14)
                  .fontWeight(500)
              }
            }
          }, (serviceItem: IHomeServiceItem) => serviceItem.title)
        }
        .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr 1fr')
        .rowsGap(rvp(23))
        .width('100%')
        .height(rvp(187))
      }
    }
    .width('100%')
    .margin({ top: rvp(43) })
  }
}