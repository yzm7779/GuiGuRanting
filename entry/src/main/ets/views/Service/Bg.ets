import rvp from "../../utils/responsive"

@Component
export struct Bg {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Stack() {
      Image($r('app.media.service_bg'))
        .width('100%').height(rvp(211 - 36) + this.topHeight)
        .objectFit(ImageFit.Fill)
      Image($r('app.media.down_arrow'))
        .width(rvp(10)).height(rvp(5))
        .margin({ bottom: rvp(14) })
    }
    .width('100%')
    .alignContent(Alignment.Bottom)

  }
}