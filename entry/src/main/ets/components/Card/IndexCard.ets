import { BORDER_RADIUS } from "../../constants/size"
import rvp from "../../utils/responsive"

@Component
export struct IndexCard {
  @BuilderParam contentBuilderParam: () => void = this.customerBuilder
  @Prop cardPadding: number = 8

  @Builder
  customerBuilder() {
  }

  build() {
    Column() {
      this.contentBuilderParam()
    }
    .width('100%')
    .padding(rvp(this.cardPadding))
    .border({
      radius: rvp(BORDER_RADIUS)
    })
    .backgroundColor($r('app.color.white'))
  }
}