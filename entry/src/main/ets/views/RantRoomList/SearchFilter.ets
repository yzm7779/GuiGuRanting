import { PADDING } from "../../constants/size";
import rvp from "../../utils/responsive";

@Component
export struct SearchFilter {
  build() {
    Row() {
      Row({ space: rvp(3) }) {
        Text('检查')
          .fontColor('#333333').fontWeight(500).fontSize(rvp(14))
        Image($r('app.media.Frame_down_arrow'))
          .fillColor('#333333')
          .width(rvp(12)).height(rvp(12))
          .margin({ bottom: rvp(6) })
      }


      Row({ space: rvp(3) }) {
        Text('支付方式')
          .fontColor('#333333').fontWeight(500).fontSize(rvp(14))
        Image($r('app.media.Frame_down_arrow'))
          .fillColor('#333333')
          .width(rvp(12)).height(rvp(12))
          .margin({ bottom: rvp(6) })
      }

      Row({ space: rvp(3) }) {
        Text('租金')
          .fontColor('#333333').fontWeight(500).fontSize(rvp(14))
        Image($r('app.media.Frame_down_arrow'))
          .fillColor('#333333')
          .width(rvp(12)).height(rvp(12))
          .margin({ bottom: rvp(6) })
      }

      Row({ space: rvp(3) }) {
        Text('排序')
          .fontColor('#333333').fontWeight(500).fontSize(rvp(14))
        Image($r('app.media.Frame_down_arrow'))
          .fillColor('#333333')
          .width(rvp(12)).height(rvp(12))
          .margin({ bottom: rvp(6) })
      }
    }
    .width('100%')
    .height(rvp(44))
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ top: rvp(20) })
  }
}