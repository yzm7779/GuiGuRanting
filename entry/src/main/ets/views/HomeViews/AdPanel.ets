import { SHADOW_RADIUS } from "../../constants/size"

@Component
export struct AdPanel {
  @Link adPicture: string

  build() {
    Image(this.adPicture)
      .height(61)
      .objectFit(ImageFit.Fill)
      .width('100%')
      .shadow({
        radius: SHADOW_RADIUS,
        color: Color.Black,
        offsetX: 0,
        offsetY: 0
      })
  }
}