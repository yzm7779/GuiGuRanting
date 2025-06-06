import { ITitleItem, ITitleList } from "../../modules/HomeData"

@Component
export struct TitleList {
  @Link titleList: ITitleList

  build() {
    Grid() {
      ForEach(this.titleList, (item: ITitleItem) => {
        GridItem() {
          Column({ space: 8 }) {
            Image(item.imageURL)
            Row({ space: 5 }) {
              Text(item.title)
                .fontSize(12)
              Text(item.sub_title)
                .fontSize(10)
                .fontColor('#999999')
            }
            .width('100%')
          }
        }
      }, (item: ITitleItem) => item.id + '')
    }
    .margin({ top: 11, bottom: 6 })
    .columnsTemplate('1fr 1fr')
    .columnsGap(24)
    .width('100%')

  }
}