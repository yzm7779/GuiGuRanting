import { SHADOW_RADIUS } from "../../constants/size"
import rvp from "../../utils/responsive"

@Component
export struct FindRoom {
  build() {
    Column() {
      Row() {
        Image($r('app.media.zhao'))
          .width(rvp(29.15)).height(rvp(23.01))
        Image($r('app.media.fang'))
          .width(rvp(29.15)).height(rvp(23.01))
      }
      .padding({ left: rvp(20), top: rvp(49) })
      .width('100%').margin({ bottom: rvp(20) })

      Text('发现你想看的房子')
        .fontSize(rvp(12))
        .fontWeight(500)
        .fontColor(Color.Black)
        .lineHeight(rvp(14))
        .width('100%')
        .padding({ left: rvp(20) })
        .margin({ bottom: rvp(20) })
      Image($r('app.media.blank'))
        .width(rvp(234)).height(rvp(221))
        .margin({ bottom: rvp(10) })
      Text('暂无想看的房源，试试如下找房方式')
        .fontColor(Color.Black)
        .fontWeight(500)
        .fontSize(rvp(16))
        .lineHeight(rvp(19))
        .margin({ bottom: rvp(20) })
      Image($r('app.media.bus_map'))
        .width(rvp(328)).height(rvp(80))
        .shadow({
          radius: SHADOW_RADIUS,
          color: $r('app.color.shadow'),
          offsetX: 0,
          offsetY: 0
        })
    }
  }
}