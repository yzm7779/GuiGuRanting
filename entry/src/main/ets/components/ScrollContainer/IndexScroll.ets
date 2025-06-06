import { IColor } from "../../modules/HomeData"
import { window } from "@kit.ArkUI"
import { common } from "@kit.AbilityKit"


@Component
export struct IndexScroll {
  @StorageProp('topHeight') topHeight: number = 0
  @BuilderParam navBuilderParam: ($$: IColor) => void = this.customBuilder
  @BuilderParam contentBuilderParam: () => void = this.customBuilder
  //scroll组件滚动总距离
  scrollY: number = 0
  //计算颜色
  @State bgColor: string = 'rgba(0,0,0,0)'
  @State fontColor: string = 'rgba(255,255,255,1)'
  //透明度
  colorOpacity: number = 0
  //获取顶部颜色
  windowClass?: window.Window
  getWindowClass = async () => {
    // const windowStage = WindowManager.getWindowStage()
    // const windowClass = await windowStage.getMainWindow()
    // this.windowClass = windowClass
    this.windowClass = await window.getLastWindow(getContext(this) as common.BaseContext)
  }
  calcColor = () => {
    if (this.scrollY < 10) {
      //到达顶部
      this.bgColor = 'rgba(255,255,255,0)'
      this.fontColor = 'rgba(255,255,255,1)'
      this.windowClass!.setWindowSystemBarProperties({
        statusBarContentColor: '#FFFFFF'
      })
    } else if (this.scrollY < 100) {
      //渐变中
      this.colorOpacity = (this.scrollY - 10) / 90
      this.bgColor = `rgba(255,255,255,${this.colorOpacity})`
      this.fontColor = `rgba(0,0,0,${this.colorOpacity})`
    } else {
      //渐变全部完成
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = 'rgb(0, 0, 0,1)'
      this.windowClass!.setWindowSystemBarProperties({
        statusBarContentColor: '#000000'
      })
    }
  }
  //滚动事件
  handleScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset
    console.log('总移动距离', this.scrollY)
    //计算颜色
    this.calcColor()
  }

  @Builder
  customBuilder() {
  }

  async aboutToAppear() {
    this.getWindowClass()
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.contentBuilderParam()
        }
      }
      .width('100%')
      .scrollBar(BarState.Off)
      .onDidScroll(this.handleScroll)

      //顶部搜索栏
      Column() {
        this.navBuilderParam({ fontColor: this.fontColor })
      }
      .backgroundColor(this.bgColor).padding({ top: this.topHeight })
    }
    .width('100%').height('100%')
    .align(Alignment.TopStart)
  }
}