import { IndexCard } from "../../components/Card/IndexCard"
import { ICleaningServiceInfo, ICleaningServiceInfoList } from "../../modules/ServiceData"
import rvp from "../../utils/responsive"

@Component
export struct ServiceClean {
  @Prop newcomerZoneImg: string
  @Prop cleaningServiceInfo: ICleaningServiceInfoList
  @State currentTabIndex: number = 0

  @Builder
  contentBuilder() {
    IndexCard() {
      Text() {
        Span('新人')
          .fontColor('#36D1A1')
        Span('专区')
      }
      .fontSize(rvp(16))
      .lineHeight(rvp(19))
      .fontWeight(700)
      .width('100%')
      .margin({ bottom: rvp(8) })

      Image(this.newcomerZoneImg)
        .width(rvp(312)).height(rvp(90))
    }

    IndexCard() {
      Text('洁净家')
        .fontSize(rvp(16))
        .lineHeight(rvp(19))
        .fontWeight(700)
        .width('100%')
        .margin({ bottom: rvp(8) })
      Row({ space: rvp(8) }) {
        ForEach(this.cleaningServiceInfo, (item: ICleaningServiceInfo) => {
          Column() {
            Image(item.img)
              .width(rvp(152)).height(rvp(115))
            Text(item.title)
              .margin({ top: rvp(8), bottom: rvp(8) })
              .fontWeight(700)
              .fontSize(rvp(14))
              .lineHeight(rvp(16))
              .width('50%')
            Text(item.subTitle)
              .fontColor('#666666')
              .fontWeight(500)
              .fontSize(rvp(12))
              .lineHeight(rvp(14))
              .width('50%')
            Row() {
              Text('到手价')
                .fontWeight(500)
                .fontSize(rvp(10))
                .fontColor('#666666')
                .margin({ right: rvp(4) })
              Text(`￥${item.priceAfterDiscounts}`)
                .fontSize(rvp(16))
                .fontWeight(500)
                .fontColor('#D9351A')
                .margin({ right: rvp(4) })
              Text(`￥${item.originalPrice}`)
                .fontWeight(500)
                .fontSize(rvp(10))
                .fontColor('#666666')
                .decoration({ type: TextDecorationType.LineThrough })

            }
            .width('50%')
          }
        }, (item: ICleaningServiceInfo) => item.title)
      }
      .width('100%')
    }
  }

  @Builder
  tabBarBuilder(title: string, subTitle: string, index: number) {
    Column() {
      if (index === this.currentTabIndex) {
        Text(title)
          .fontSize(rvp(18)).fontWeight(700)
          .margin({ bottom: rvp(2) })
      } else {
        Text(title)
          .fontSize(rvp(14)).fontWeight(700)
          .margin({ bottom: rvp(3) })
      }

      Text(subTitle)
        .fontSize(rvp(12)).fontWeight(500).fontColor('#666666')
      if (index === this.currentTabIndex) {
        Row() {
        }
        .width(rvp(20))
        .height(rvp(4))
        .backgroundColor('#51BB9E')
        .border({ radius: rvp(9) })
        .margin({ top: rvp(2) })
      }
    }
    .height('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs() {
      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('会员精选', '专业服务', 0))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('居家保洁', '解放双手', 1))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('深层清洗', '高温蒸洗', 2))

      TabContent() {
        this.contentBuilder()
      }.tabBar(this.tabBarBuilder('新居乔迁', '一站搬家', 3))
    }
    .height(rvp(440))
    .onChange((index: number) => {
      this.currentTabIndex = index
    })
    .barHeight(rvp(70))
    .scrollable(false)
  }
}