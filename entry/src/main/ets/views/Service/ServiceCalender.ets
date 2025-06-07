import { IndexCard } from "../../components/Card/IndexCard"
import { IServiceActivity } from "../../modules/ServiceData"
import getCalender from "../../utils/calender"
import rvp from "../../utils/responsive"

@Component
export struct ServiceCalender {
  @Prop serviceActivity: IServiceActivity
  @State calenderList: string[] = []

  aboutToAppear(): void {
    const data = getCalender()
    this.calenderList = data
    console.log(JSON.stringify(data), '这是日历数据');
  }

  build() {
    Column() {
      IndexCard({ cardPadding: 0 }) {
        Row() {
          Text('服务日历')
            .fontWeight(700).fontSize(rvp(16)).lineHeight(rvp(19))
          Row({ space: 5 }) {
            Text('全部服务')
              .fontColor('#999999').fontWeight(500).fontSize(rvp(12)).lineHeight(rvp(14))
            Image($r('app.media.right_arrow'))
              .fillColor('#999999').width(rvp(4)).height(rvp(6))
          }
        }
        .width('100%')
        .padding({ left: rvp(8), right: rvp(8), top: rvp(8) })
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          ForEach(this.calenderList, (item: string, index) => {
            if (index === 2) {
              Text() {
                Span(item)
                  .fontWeight(700).fontSize(rvp(16)).lineHeight(rvp(19))
                Span('月')
                  .fontSize(rvp(14)).lineHeight(rvp(16)).fontColor('#666666').fontWeight(500)
              }
              .backgroundColor('#CDFFD9')
              .border({ radius: rvp(4) })
              .width(rvp(46))
              .height(rvp(32))
              .textAlign(TextAlign.Center)
            } else {
              Text() {
                Span(item)
                  .fontWeight(700).fontSize(rvp(16)).lineHeight(rvp(19))
                Span('月')
                  .fontSize(rvp(14)).lineHeight(rvp(16)).fontColor('#666666').fontWeight(500)
              }
              .width(rvp(46)).height(rvp(32))
              .textAlign(TextAlign.Center)
            }
          }, (item: string) => item)
        }
        .width('100%')
        .padding({ left: rvp(8), right: rvp(8), top: rvp(16) }).justifyContent(FlexAlign.SpaceBetween)

        Column() {
          Text(this.serviceActivity.name)
            .width('100%').fontWeight(700).fontSize(rvp(14)).lineHeight(rvp(16))
          Row() {
            Image(this.serviceActivity.img)
              .width(rvp(100)).height(rvp(100)).margin({ bottom: rvp(8) })
              .border({ radius: rvp(4) })
            Column() {
              Text(this.serviceActivity.title)
                .width('100%')
                .padding({ left: rvp(8) })
                .margin({ bottom: rvp(8) })
                .fontWeight(500)
                .fontSize(rvp(14))
                .lineHeight(rvp(16))
              Text(this.serviceActivity.subTitle)
                .width('100%')
                .padding({ left: rvp(8) })
                .fontWeight(500)
                .fontSize(rvp(12))
                .lineHeight(rvp(14))
              Text('立即参与')
                .backgroundColor('#CDFFD9')
                .width(rvp(70))
                .height(rvp(24))
                .border({ radius: rvp(4) })
                .fontColor('#1F632F')
                .fontWeight(500)
                .fontSize(rvp(12))
                .textAlign(TextAlign.Center)
                .margin({ top: rvp(23) })
            }
          }
          .padding({ top: rvp(8) })
        }
        .width('100%')
        .height(rvp(140))
        .linearGradient({
          angle: 210,
          colors: [['#DEFBE5', 0], ['#FFFFFF', 0.3]]
        })
        .margin({ top: rvp(18) })
        .padding({ left: rvp(8), right: rvp(16) })
      }
    }
    .width('100%')
    .margin({ top: rvp(8) })
  }
}