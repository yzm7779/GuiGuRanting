import { IndexScroll } from "../components/ScrollContainer/IndexScroll"
import { PADDING } from "../constants/size"
import rvp from "../utils/responsive"
import Bg from "../views/MyViews/Bg"
import UserInfo from "../views/MyViews/UserInfo"

@Component
export struct MinePage {
  @Builder
  navBuilder() {
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo()
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(44) })
    }.width('100%')
  }

  build() {
    IndexScroll({
      contentBuilderParam: () => {
        this.contentBuilder()
      },
      navBuilderParam: this.navBuilder,
    })
  }
}