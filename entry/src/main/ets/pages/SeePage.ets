import { FindRoom } from "../views/See/FindRoom";
import { NavBar } from "../views/See/NavBar";


@Component
export struct SeePage {
  build() {
    Column() {
      NavBar()
      FindRoom()
    }
    .width('100%').height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom, // 渐变方向
      colors: [['#DEFBE5', 0], ['#FFFFFF', 0.3], ['#FFFFFF', 1]]
    })

  }
}