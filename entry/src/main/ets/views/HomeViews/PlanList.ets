import { IPlanItem, IPlanList } from "../../modules/HomeData"

@Component
export struct PlanList {
  @Link planList: IPlanList

  build() {
    Row() {
      ForEach(this.planList, (item: IPlanItem) => {
        Image(item.imageURL)
          .width(78).height(60).objectFit(ImageFit.Fill)
      }, (item: IPlanItem) => item.id + '')
    }
    .margin({ top: 18, bottom: 9 })
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')

  }
}