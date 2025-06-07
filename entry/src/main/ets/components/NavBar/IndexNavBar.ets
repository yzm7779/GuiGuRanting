import { PADDING } from "../../constants/size";
import rvp from "../../utils/responsive";
import { router } from "@kit.ArkUI";

@Component
export struct IndexNavBar {
  @Prop title: string

  build() {
    Stack() {
      Text(this.title)
        .fontWeight(500)
        .fontSize(rvp(16))
        .textAlign(TextAlign.Center)
        .width('100%')
      Image($r('app.media.Frame'))
        .width(rvp(24)).height(rvp(24))
        .onClick(() => {
          router.back()
        })
    }
    .width('100%')
    .height(rvp(44))
    .padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(36) })
    .align(Alignment.Start)
  }
}