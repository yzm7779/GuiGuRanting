import { searchHomeListApi } from "../../api/discoverData";
import { BORDER_RADIUS } from "../../constants/size";
import { ITagItem } from "../../modules/HomeData";
import { IRoomItem, IRoomList, ISearchListParams, RoomDataSource } from "../../modules/ReaearchRoomList";
import globalEmitter from "../../utils/emitter";
import rvp from "../../utils/responsive";

@Component
export struct RoomList {
  @StorageProp('windowHeight') windowHeight: number = 0
  @StorageProp('topHeight') topHeight: number = 0
  @State roomList: RoomDataSource = new RoomDataSource()
  @State roomTotal: number = 0
  @State searchOption: ISearchListParams = {
    page: 1,
    limit: 30
  }
  @State isMoreData: boolean = true

  async searchRoomList() {
    const res = await searchHomeListApi(this.searchOption)
    if (this.searchOption.page === 1) {
      this.roomList.setList(res.records)
    } else {
      this.roomList.pushList(res.records)
    }
    this.roomTotal = Number(res.total)
    console.log(JSON.stringify(res), '这是房源数据吗')
  }

  loaderMore() {
    if (this.roomTotal <= this.roomList.totalCount()) {
      this.isMoreData = true
      return
    }
    this.searchOption.page++
    this.searchRoomList()
  }

  aboutToAppear(): void {
    this.searchRoomList()
    //绑定事件
    globalEmitter.on('search', (searchOptions: Partial<ISearchListParams>) => {
      const keys = Object.keys(searchOptions)
      keys.forEach(key => {
        const val: string = Reflect.get(searchOptions, key)
        Reflect.set(this.searchOption, key, val)
      })
      this.searchOption.page = 1
      this.searchRoomList()
    })
  }

  getText(room: IRoomItem): string {
    return Reflect.get(room.activity!, '#text')
  }

  @Builder
  footerBuilder() {
    if (!this.isMoreData) {
      Row() {
        Refresh({ refreshing: true })
          .outlineColor(Color.Black)
        Text('数据加载中...')
          .fontSize(rvp(12))
          .margin({ top: rvp(5) })
      }
      .width('100%').justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
    } else {
      Row() {
        Text('已经到底了')
          .fontSize(rvp(12))
          .margin({ top: rvp(5) })
      }
      .width('100%').justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
    }
  }

  build() {
    Column() {
      WaterFlow({ footer: this.footerBuilder() }) {
        LazyForEach(this.roomList, (room: IRoomItem) => {
          FlowItem() {

            Column() {
              if (room.activity) {
                Column() {
                  Row({ space: rvp(4) }) {
                    Image(room.activity.icon)
                      .width(rvp(26)).height(rvp(26))
                    Text(room.activity.title)
                      .fontWeight(700).fontSize(rvp(14))
                  }
                  .width('100%')

                  Row() {
                    Text(this.getText(room))
                      .fontColor(room.activity.textColor)
                      .backgroundColor(room.activity.textBackGroundColor)
                      .fontWeight(700)
                      .fontSize(rvp(10))
                      .height(rvp(20))
                      .lineHeight(rvp(12))
                      .padding({
                        top: rvp(4),
                        bottom: rvp(4),
                        left: rvp(8),
                        right: rvp(10)
                      })
                      .border({ radius: rvp(21) })
                  }
                  .justifyContent(FlexAlign.Start)
                  .width('100%')
                  .margin({ top: rvp(3), bottom: rvp(3) })
                }
                .padding({ left: rvp(13) })
              }
              //图片和定位区域
              Stack() {
                Image(room.housePicture)
                  .width(room.activity ? rvp(140) : '100%')
                  .height(room.activity ? 165 : 120)
                  .objectFit(ImageFit.Fill)
                  .border({
                    radius: {
                      topLeft: BORDER_RADIUS,
                      topRight: BORDER_RADIUS,
                      bottomLeft: room.activity ? BORDER_RADIUS : 0,
                      bottomRight: room.activity ? BORDER_RADIUS : 0,
                    }
                  })
                  .margin({ left: rvp(10) })
                if (!room.activity) {
                  Row({ space: 4 }) {
                    Image($r('app.media.location'))
                      .width(16)
                    Text(room.address)
                      .fontSize(10).fontWeight(500)
                      .fontColor(Color.White)
                  }
                  .margin({
                    bottom: 6, left: 6
                  })
                  .padding({ left: 12 })
                }
              }
              .align(Alignment.BottomStart)

              //文字描述区域
              Column() {
                //价格和房间大小
                Row() {
                  Text() {
                    Span(`￥${room.rentPriceListing}`)
                      .fontSize(14)
                    Span(room.rentPriceUnit)
                      .fontSize(12)
                  }
                  .fontWeight(500).fontColor('#E03810')

                  Text(`${room.rentArea}m²`)
                    .fontSize(10).fontWeight(500).fontColor('#999999')
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .margin({ top: 11 })

                //标题
                Text(room.houseTitle)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
                  .fontSize(14)
                  .margin({ top: 2 })
                  .fontWeight(500)
                //标签项
                Row({ space: 6 }) {
                  ForEach(room.tags.slice(0, 2), (tag: ITagItem, index) => {
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


          .width(rvp(160)).height(room.activity ? rvp(320) : rvp(210))
        }, (room: IRoomItem) => room.id)
      }
      .width('100%')
      .height(this.windowHeight - this.topHeight - rvp(88))
      .columnsTemplate('1fr 1fr')
      .columnsGap(rvp(8))
      .padding({ left: rvp(8), right: rvp(8) })
      .onReachEnd(() => {
        this.loaderMore()
      })

      // .onReachStart(() => {
      //   this.searchOption.page = 1
      //   this.searchRoomList()
      // })
    }
    .width('100%')
  }
}