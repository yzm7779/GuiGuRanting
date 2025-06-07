import { PADDING } from "../../constants/size"
import rvp from "../../utils/responsive"

@Component
export struct NavBar {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Row() {
      Row({ space: rvp(6) }) {
        Text('请选择地址')
          .fontSize(rvp(12)).fontWeight(500)
          .fontColor(Color.White)
        Image($r('app.media.down_arrow2'))
          .width(rvp(6)).height(rvp(6))
      }

      Row({ space: rvp(28) }) {
        Column({ space: rvp(1) }) {
          Image($r('app.media.message'))
            .width(rvp(20)).height(rvp(20))
            .fillColor(Color.White)
          Text('消息')
            .fontSize(rvp(10)).fontWeight(500)
            .fontColor(Color.White)
        }

        Column({ space: rvp(1) }) {
          Image($r('app.media.customer'))
            .width(rvp(20)).height(rvp(20))
            .fillColor(Color.White)
          Text('客服')
            .fontSize(rvp(10)).fontWeight(500)
            .fontColor(Color.White)
        }
      }

    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })

    //.margin({ top: this.topHeight })
  }
}