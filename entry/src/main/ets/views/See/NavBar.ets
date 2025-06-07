import { PADDING } from "../../constants/size"
import rvp from "../../utils/responsive"

@Component
export struct NavBar {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Row() {
      Row({ space: rvp(6) }) {
        Image($r('app.media.green_bag'))
          .width(rvp(16)).height(rvp(16))
        Text('填写通勤地址')
          .fontSize(rvp(12)).fontWeight(500)
          .fontColor($r('sys.color.black'))
      }

      Row({ space: rvp(28) }) {
        Column({ space: rvp(1) }) {
          Image($r('app.media.message'))
            .width(rvp(20)).height(rvp(20))
            .fillColor(Color.Black)
          Text('消息')
            .fontSize(rvp(10)).fontWeight(500)
        }

        Column({ space: rvp(1) }) {
          Image($r('app.media.route'))
            .width(rvp(20)).height(rvp(20))
          Text('行程')
            .fontSize(rvp(10)).fontWeight(500)
        }
      }

    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .margin({ top: this.topHeight })
  }
}