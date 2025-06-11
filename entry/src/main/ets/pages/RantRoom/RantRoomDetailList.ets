import { getRoomDetailApi, rantRoomApi } from '../../api/roomDetail'
import { promptAction, router } from '@kit.ArkUI'
import { IParam, IRantRoomItem, IRentRoomDetail, IRoomType, IRoomTypeList } from '../../modules/RantRoomDetailData'
import { IndexNavBar } from '../../components/NavBar/IndexNavBar'
import rvp from '../../utils/responsive'
import { PADDING } from '../../constants/size'
import { bookDrawer } from '../../components/Drawer'
import createDateList, { IDateItem, IDateList } from '../../utils/dateList'

@Entry
@Component
struct RantRoomDetailList {
  @State isVisible: boolean = false
  //房间的所有详细数据
  @State room: IRentRoomDetail = {
    "houseTitle": '',
    "address": '',
    "rentPriceUnit": '',
    "housePicture": [],
    "tags": [],
    "rentPriceUnitListing": '',
    rentPriceListing: '',
    "distanceInfo": {
      "distance": '',
      "line": '',
      "name": ''
    },
    "rentTerm": {
      "checkInTime": "",
      "term": "",
      "kitchen": "",
      "lift": "",
      "seeTime": "",
      "year": "",
      "renovation": "",
      "grounding": "",
      "heating": "",
      "green": "",
      "protection": "",
      "house": ""
    },
    "metaInfo": [],
    "id": '',
    "rentArea": '',
    "discounts": [],
    "householdItem": [],
    "support": [],
    "rentInfo": []
  }
  //图片轮播条
  @State roomList: IRoomTypeList = []
  //图片轮播区域
  @State roomPictureList: string[] = []
  //当前房间下标
  @State currentRoomIndex: number = 0
  scroller4RoomPic: Scroller = new Scroller()
  @State dateList: IDateList = createDateList()
  @State currentDate: IDateItem = this.dateList[0]
  @State isShowDateList: boolean = false
  @State reservationData: IRantRoomItem = {
    name: '',
    phone: '',
    date: '',
    comment: '',
    houseId: ''
  }
  //发送请求获得房间的详细数据
  getRoomDetail = async () => {
    const params = router.getParams() as IParam
    const result = await getRoomDetailApi(params.id)
    this.room = result
    //获得图片轮播条
    this.roomList = result.housePicture.map(item => {
      const res: IRoomType = {
        name: item.spaceName,
        total: item.picList.length
      }
      return res
    })
    this.roomPictureList = result.housePicture.reduce((p: string[], c) => {
      return p.concat(c.picList)
    }, [])
    console.log(JSON.stringify(result), '房间详细信息')
  }

  aboutToAppear(): void {
    this.getRoomDetail() //调用接口函数
  }

  build() {
    Stack() {
      Column() {
        IndexNavBar({ title: this.room.houseTitle })
        List({ space: rvp(16) }) {
          ForEach(this.roomList, (roomItem: IRoomType, index: number) => {
            ListItem() {
              Column() {
                Text(roomItem.name + '(' + roomItem.total + ')')
                  .fontWeight(500)
                  .fontSize(rvp(14))
                  .fontColor(this.currentRoomIndex === index ? 'rgba(38, 38, 38, 1)' : 'rgba(102, 102, 102, 1)')
                if (this.currentRoomIndex === index) {
                  Row() {
                  }.backgroundColor('rgba(54, 209, 161, 1)')
                  .width(rvp(16)).height(rvp(2))
                  .margin({ top: rvp(4) })
                }
              }
            }
            .onClick(() => {
              this.currentRoomIndex = index
              let scrollIndex = 0
              for (let i = 0; i < this.roomList.length; i++) {
                if (i < this.currentRoomIndex) {
                  scrollIndex += this.roomList[i].total
                  console.log('这是当前的图片长度', this.roomList[i].total)
                }
              }
              this.scroller4RoomPic.scrollToIndex(scrollIndex, true)
            })
          }, (roomItem: IRoomType) => roomItem.name)
        }
        .listDirection(Axis.Horizontal)
        .height(rvp(54))
        .padding(rvp(PADDING))
        .edgeEffect(EdgeEffect.None)
        .scrollBar(BarState.Off)

        List({ scroller: this.scroller4RoomPic }) {
          ForEach(this.roomPictureList, (roomPic: string) => {
            ListItem() {
              Image(roomPic)
                .width(rvp(318)).height('100%').objectFit(ImageFit.Fill)
                .margin({ left: rvp(16) })
            }
          }, (roomPic: string) => roomPic)
          ListItem() {
          }.width(rvp(8))
        }
        .listDirection(Axis.Horizontal)
        .height(rvp(208))
        .edgeEffect(EdgeEffect.None)
        .scrollBar(BarState.Off)
        .onScrollIndex((startIndex) => {
          this.currentRoomIndex = this.roomList.findIndex((item) => {
            if (startIndex < item.total) {
              return true
            } else {
              startIndex -= item.total
              return false
            }
          })
        })

        Column() {
          Row() {
            Column({ space: 4 }) {
              Image($r('app.media.love'))
                .width(18).height(18).fillColor(Color.Black)
              Text('99+')
                .fontWeight(500).fontSize(10)
                .fontColor('rgba(153, 153, 153, 1)')
            }
            .margin({ right: 27 })

            Column({ space: 4 }) {
              Image($r('app.media.navigation'))
                .width(18).height(18).fillColor(Color.Black)
              Text('咨询')
                .fontWeight(500).fontSize(10)
                .fontColor('rgba(153, 153, 153, 1)')
            }
            .margin({ right: 21 })

            Button('立即预定')
              .width(113)
              .height(34)
              .backgroundColor('rgba(36, 161, 123, 1)')
              .type(ButtonType.Normal)
              .border({ radius: 2 })
              .margin({ right: 14 })
              .onClick(() => {
                this.isVisible = true
              })
            Button('去看看')
              .width(113)
              .height(34)
              .backgroundColor('rgba(54, 209, 161, 1)')
              .type(ButtonType.Normal)
              .border({ radius: 2 })
          }
          .height(rvp(50))
          .padding({
            left: 10,
            right: 10,
            bottom: 8,
            top: 8
          })

        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)
      }
      .width('100%').height('100%')

      bookDrawer({ visible: $isVisible, drawerHeight: 181 }) {
        this.drawerBuilder()
      }
    }
  }

  @Builder
  drawerBuilder() {
    Column() {
      Text('预约信息')
        .width('100%')
        .fontWeight(700)
        .fontSize(18)
        .fontWeight(500)
        .fontColor('rgba(0, 0, 0, 1)')
        .padding({ bottom: 16 })
      Column({ space: 20 }) {
        Row() {
          Text('姓名')
            .width(72)
          TextInput({ placeholder: '请输入姓名' })
            .layoutWeight(1)
            .border({ radius: 0 })
            .backgroundColor(Color.Transparent)
            .placeholderColor('rgba(153, 153, 153, 1)')
            .maxLines(1)
            .padding(0)
            .onChange((val) => {
              this.reservationData.name = val
            })

        }
        .width('100%')

        Row() {
          Text('手机号')
            .width(72)
          TextInput({ placeholder: '请输入手机号' })
            .layoutWeight(1)
            .border({ radius: 0 })
            .backgroundColor(Color.Transparent)
            .placeholderColor('rgba(153, 153, 153, 1)')
            .maxLines(1)
            .padding(0)
            .onChange((val) => {
              this.reservationData.phone = val
            })
        }
        .width('100%')

        Row() {
          Text('预约日期')
            .width(72)
          Text(`${this.currentDate.date}(${this.currentDate.week})`)
            .layoutWeight(1)
          if (this.isShowDateList === false) {
            Image($r('app.media.Frame_151'))
              .fillColor('rgba(153, 153, 153, 1)')
              .width(24).height(24)
              .onClick(() => {
                this.isShowDateList = !this.isShowDateList
              })
          } else {
            Image($r('app.media.Frame_152'))
              .fillColor('rgba(153, 153, 153, 1)')
              .width(24).height(24)
              .onClick(() => {
                this.isShowDateList = !this.isShowDateList
              })
          }

          // TextInput({ placeholder: '请输入手机号' })
          //   .layoutWeight(1)
          //   .border({ radius: 0 })
          //   .backgroundColor(Color.Transparent)
          //   .placeholderColor('rgba(153, 153, 153, 1)')
          //   .maxLines(1)
          //   .padding(0)
        }
        .width('100%')

        if (this.isShowDateList) {
          Grid() {
            ForEach(this.dateList, (dateItem: IDateItem) => {
              GridItem() {
                Column() {
                  Text(dateItem.week)
                    .fontColor(this.currentDate.date === dateItem.date ? 'rgba(36, 161, 123, 1)' :
                      'rgba(153, 153, 153, 1)')
                    .fontSize(10)
                    .fontWeight(500)
                  Text(dateItem.date)
                    .fontSize(10)
                    .fontWeight(500)
                    .fontColor(this.currentDate.date === dateItem.date ? 'rgba(36, 161, 123, 1)' :
                      'rgba(153, 153, 153, 1)')
                }
                .width(73).height(32)
                .border({
                  radius: 4,
                  color: this.currentDate.date === dateItem.date ? 'rgba(36, 161, 123, 1)' : 'rgba(153, 153, 153, 1)',
                  width: 1
                })
                .justifyContent(FlexAlign.Center)
              }
              .onClick(() => {
                this.currentDate = dateItem
              })
            }, (dateItem: IDateItem) => dateItem.date)

          }
          .columnsTemplate('1fr 1fr 1fr')
          .rowsGap(6)
          .margin({ left: 72 })
          .height(112)
        }


        Row() {
          Column() {
            Text('备注信息')
              .width(72)
          }
          .height(60)

          TextArea({ placeholder: '请输入备注信息' })
            .layoutWeight(1)
            .border({ radius: 0 })
            .backgroundColor('rgba(246, 246, 246, 1)')
            .placeholderColor('rgba(153, 153, 153, 1)')
            .padding(0)
            .border({ radius: 8 })
            .padding(10)
            .maxLines(2)
            .height(60)
            .onChange((val) => {
              this.reservationData.comment = val
            })
        }
        .width('100%')
        .margin({ bottom: 16 })

      }
      .padding(16)
      .width('100%')
      .backgroundColor(Color.White)
      .border({ radius: 4 })

      Button('预约看房')
        .backgroundColor('rgba(36, 161, 123, 1)')
        .type(ButtonType.Normal)
        .border({ radius: 4 })
        .height(42)
        .width('100%')
        .margin({ bottom: 50 })
        .onClick(async () => {
          const params = router.getParams() as IParam
          const data: IRantRoomItem = {
            name: this.reservationData.name,
            phone: this.reservationData.phone,
            comment: this.reservationData.comment,
            date: this.currentDate.date,
            houseId: params.id
          }
          console.log('这是预约', JSON.stringify(data))

          await rantRoomApi(data)
          this.isVisible = false
          promptAction.showToast({
            message: '预约成功'
          })
        })
    }
    .width('100%')
  }
}