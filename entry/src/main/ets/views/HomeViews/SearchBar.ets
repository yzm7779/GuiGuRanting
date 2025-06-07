import { PADDING } from "../../constants/size"
import { router } from "@kit.ArkUI"

@Component
export struct SearchBar {
  @Prop fontColor: string

  build() {
    Row() {
      //左侧地理位置
      Text('北京')
        .fontColor(this.fontColor)
        .fontSize(14)

      //中间的搜索框
      Row() {
        Image($r('app.media.search'))
          .width(18).height(18)
          .margin({ right: 10 })
        TextInput({ placeholder: '公司/地铁/小区，马上搜索' })
          .placeholderFont({ size: 12 })
          .backgroundColor(Color.White)
          .layoutWeight(1)
          .padding(0)
          .caretColor(Color.Black)
          .stateStyles({ pressed: textInputStyle })
        Column() {
        }
        .width(1).backgroundColor('#D7D7D7').height(18).margin({ left: 10, right: 10 })

        Image($r('app.media.position'))
          .imageStyles(18)

      }
      .width(244)
      .height('100%')
      .backgroundColor(Color.White)
      .border({
        width: 1,
        radius: 52,
        color: '#D7D7D7'
      })
      .padding({ left: PADDING, right: PADDING })
      .onClick(() => {
        router.pushUrl({
          url: 'pages/RantRoom/RantRoomList'
        })
      })

      //右侧的图标
      Image($r('app.media.message'))
        .imageStyles(24)
        .fillColor(this.fontColor)

    }
    .width('100%')
    .height(38)
    .padding({
      left: PADDING,
      right: PADDING,
      top: 4,
      bottom: 4
    })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Styles
function textInputStyle() {
  .backgroundColor(Color.White)
}

@Extend(Image)
function imageStyles(size: number) {
  .width(size).height(size).objectFit(ImageFit.Fill)
}