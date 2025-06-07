import { IVipServiceItem, IVipServiceList } from "../../modules/ServiceData"
import rvp from "../../utils/responsive"

@Component
export struct VIP {
  @StorageProp('topHeight') topHeight: number = 0
  @Prop vipServiceList: IVipServiceList
  //判断单位
  getUnit = (name: string): string => {
    switch (name) {
      case '余额':
        return '元';
      case '优惠券':
        return '张';
      case '会员特权':
        return '项';
      case '会员福利':
        return '个';
      default:
        return ''
    }
  }

  build() {
    Stack() {
      Image($r('app.media.vip_bg'))
        .width(rvp(328)).height('100%')
        .objectFit(ImageFit.Fill)
      Column({ space: rvp(14) }) {
        Row() {
          Image($r('app.media.crown'))
            .width(rvp(18)).height(rvp(18))
          Text('开通谷粒卡享特权')
            .fontWeight(500).fontSize(rvp(16))
            .fontColor(Color.White)
            .margin({ left: rvp(8), right: rvp(52) })
          Image($r('app.media.vip'))
            .width(rvp(42)).height(rvp(19))
        }

        Row({ space: rvp(32) }) {
          ForEach(this.vipServiceList, (vip: IVipServiceItem) => {
            Column({ space: rvp(6) }) {
              Text(vip.name)
                .fontColor(Color.White).fontSize(rvp(12))
              Text() {
                Span(vip.content.toString())
                  .fontWeight(500).fontSize(rvp(16))
                Span(this.getUnit(vip.name))
                  .fontSize(rvp(10))
              }.fontColor(Color.White)
            }
          }, (vip: IVipServiceItem) => vip.name)
        }
      }
      .height('100%').justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .margin({ top: rvp(49) + this.topHeight }).height(rvp(99))
  }
}