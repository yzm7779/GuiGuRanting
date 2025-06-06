import { INavItem, INavList } from "../../modules/HomeData"

@Component
export struct NavList {
  @Link navList: INavList

  build() {
    Grid() {
      ForEach(this.navList, (item: INavItem) => {
        GridItem() {
          Column({ space: 8 }) {
            Image(item.imageURL)
              .width(57).height(56)
            Text(item.title)
              .fontSize(12).fontWeight(500)
          }
        }
      }, (item: INavItem) => item.id + '')
    }
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .height(170)
    .margin({ top: 24 })
    .rowsGap(14)
    .columnsGap(23)
  }
}