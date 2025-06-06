import { BannerListDataSource, IBannerItem, IBannerList } from "../../modules/HomeData"

@Component
export struct SwiperLayout {
  @StorageProp('topHeight') topHeight: number = 0
  @ObjectLink bannerList: BannerListDataSource

  build() {
    Swiper() {
      LazyForEach(this.bannerList, (item: IBannerItem) => {
        Image(item.imageURL)
          .width('100%').height('100%').objectFit(ImageFit.Fill)

      }, (banner: IBannerItem) => banner.id + '')
    }
    .width('100%').height(211 - 36 + this.topHeight)
    .autoPlay(true)
    .indicator(
      new DotIndicator()
        .color('#cccbcb')
        .selectedColor('#479459')
    )

  }
}