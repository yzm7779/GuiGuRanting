import { getHomeRecommendApi } from '../../api/home'
import { BORDER_RADIUS, PADDING, PADDING_S } from '../../constants/size'
import { IRoomRecommendItem, IRoomRecommendList, ITagItem, RoomRecommendDataSource } from '../../modules/HomeData'
import { router } from '@kit.ArkUI'

@Component
export struct RoomRecommend {
  @State roomRecommendDataSource: RoomRecommendDataSource = new RoomRecommendDataSource([])
  //获取房源推荐列表
  getRoomRecommendList = async () => {
    const roomRecommendList = await getHomeRecommendApi();
    this.roomRecommendDataSource = new RoomRecommendDataSource(roomRecommendList)
  }

  aboutToAppear(): void {
    this.getRoomRecommendList()
  }

  build() {
    Column() {
      this.RoomNav()
      this.RoomList()
    }
    .width('100%')
    .margin({ top: 33 })

  }

  //房源推荐导航栏
  @Builder
  RoomNav() {
    Row() {
      Text() {
        Span('周边房源')
          .fontColor($r('sys.color.black'))
        Span('推荐')
          .fontColor('#36D1A1')
      }
      .fontSize(16).fontWeight(700)

      Row({ space: 10 }) {
        Text('更多推荐')
          .fontSize(10)
          .fontColor($r('sys.color.black'))
        Image($r('app.media.arrow_right'))
          .width(4).height(8)
          .fillColor('#666666')
      }
      .onClick(() => {
        router.pushUrl({
          url: 'pages/RantRoom/RantRoomList'
        })
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: PADDING, right: PADDING })
  }

  //房源推荐列表
  @Builder
  RoomList() {
    if (this.roomRecommendDataSource.roomRecommendList.length) {
      Grid() {
        LazyForEach(this.roomRecommendDataSource, (item: IRoomRecommendItem) => {
          GridItem() {
            Column() {
              //图片和定位区域
              Stack() {
                Image(item.housePicture)
                  .width('100%').height(120)
                  .objectFit(ImageFit.Fill)
                  .border({ radius: { topLeft: BORDER_RADIUS, topRight: BORDER_RADIUS } })
                Row({ space: 4 }) {
                  Image($r('app.media.location'))
                    .width(16)
                  Text(item.address)
                    .fontSize(10).fontWeight(500)
                    .fontColor(Color.White)
                }
                .margin({
                  bottom: 6, left: 6
                })
              }
              .align(Alignment.BottomStart)

              //文字描述区域
              Column() {
                //价格和房间大小
                Row() {
                  Text() {
                    Span(`￥${item.rentPriceListing}`)
                      .fontSize(14)
                    Span(item.rentPriceUnit)
                      .fontSize(12)
                  }
                  .fontWeight(500).fontColor('#E03810')

                  Text(`${item.rentArea}m²`)
                    .fontSize(10).fontWeight(500).fontColor('#999999')
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .margin({ top: 11 })

                //标题
                Text(item.houseTitle)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
                  .fontSize(14)
                  .margin({ top: 2 })
                  .fontWeight(500)
                //标签项
                Row({ space: 6 }) {
                  ForEach(item.tags.slice(0, 2), (tag: ITagItem, index) => {
                    Text(tag.name)
                      .padding({
                        top: 1,
                        bottom: 1,
                        left: 6,
                        right: 6
                      })
                      .fontColor(index === 0 ? $r('app.color.white') : '#B3B3B3')
                      .backgroundColor(index === 0 ? $r('app.color.primary') : $r('app.color.bg_gray'))
                      .fontSize(12)
                  }, (tag: ITagItem) => tag.name)
                }.width('100%').margin({ top: 9 })

              }
              .backgroundColor(Color.White)
              .padding({ left: 12, right: 12, bottom: 12 })

            }

          }
        }, (item: IRoomRecommendItem) => item.id + '')
      }
      .columnsGap(8)
      .rowsGap(8)
      .width('100%')
      .padding({
        left: PADDING,
        right: PADDING,
        top: 8,
        bottom: 8
      })
      .backgroundColor($r('app.color.bg_gray'))
      .columnsTemplate('1fr 1fr ')
    }

  }
}