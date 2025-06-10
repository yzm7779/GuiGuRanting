import {
  getSearchPositionCityApi,
  getSearchPositionDistrictApi,
  getSearchPositionProvinceApi
} from "../../api/searchPosition";
import { PADDING } from "../../constants/size";
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IProvinceItem,
  IProvinceList,
  ISearchListParams,
  ISortItem,
  ISortItemList
} from "../../modules/ReaearchRoomList";
import globalEmitter from "../../utils/emitter";
import rvp from "../../utils/responsive";
import { convertxml } from "@kit.ArkTS";
import { IRantPrice, IRantPriceList } from "../../modules/HomeData";

@Component
export struct SearchFilter {
  @State isShowSearch: boolean = false
  @State searchTextList: string[] = ['位置', '支付方式', '租金', '排序']
  @State currentSearchText: string = ''
  //获取省份数据
  @State provinceList: IProvinceList = []
  @State provinceIndex: string = ''
  //获取城市数据
  @State cityList: ICityList = []
  @State cityIndex: string = ''
  //获取区域数据
  @State districtList: IDistrictList = []
  @State districtIndex: string = ''
  @State submitDistrictName: string = ''
  @State submitProvinceIndex: string = ''
  @State submitCityIndex: string = ''
  @State submitDistrictIndex: string = ''
  getDistrictList = async () => {
    this.districtList = await getSearchPositionDistrictApi(this.cityIndex)
    console.log(JSON.stringify(this.districtList), '这是地区的数组')
    this.districtIndex = this.districtIndex || this.districtList[0].code
  }
  getCityList = async () => {
    this.cityList = await getSearchPositionCityApi(this.provinceIndex)
    this.cityIndex = this.cityIndex || this.cityList[0].code
    console.log(JSON.stringify(this.cityList), '这是城市的数组')
    this.getDistrictList()
  }
  getProvinceList = async () => {
    this.provinceList = await getSearchPositionProvinceApi()
    this.provinceIndex = this.provinceIndex || this.provinceList[0].code
    console.log(JSON.stringify(this.provinceList), '这是省份的数组')
    this.getCityList()
  }
  @State paymentWayList: string[] = ['月付', '季付', '季年付', '年付']
  @State currentPaymentWay: string = ''
  @State submitPaymentWay: string = ''
  @State rantTypeList: IRantPriceList = [
    {
      id: 1,
      minRent: '0',
      maxRent: '0',
      text: '不限'
    },
    {
      id: 2,
      minRent: '0',
      maxRent: '1500',
      text: '1500元以下'
    },
    {
      id: 3,
      minRent: '1500',
      maxRent: '2500',
      text: '1500-2500元'
    },
    {
      id: 4,
      minRent: '2500',
      maxRent: '3500',
      text: '2500-3500元'
    },
    {
      id: 5,
      minRent: '3500',
      maxRent: '4500',
      text: '3500-4500元'
    },
    {
      id: 6,
      minRent: '4500',
      maxRent: '6000',
      text: '4500-6000元'
    },
    {
      id: 7,
      minRent: '6000',
      maxRent: '8000',
      text: '6000-8000元'
    },
    {
      id: 8,
      minRent: '8000',
      maxRent: '10000',
      text: '8000-10000元'
    },
    {
      id: 9,
      minRent: '10000',
      maxRent: '0',
      text: '10000元以上'
    }
  ]
  @State currentRantPriceId: number = 0
  @State submitRantPriceId: number = 0
  @State sortList: ISortItemList = [
    {
      icon: $r('app.media.sort'),
      text: '综合排序',
      orderBy: '',
      orderType: ''
    },
    {
      icon: $r('app.media.price'),
      text: '价格从低到高',
      orderBy: 'price',
      orderType: 'asc'
    },
    {
      icon: $r('app.media.price'),
      text: '价格从高到低',
      orderBy: 'price',
      orderType: 'desc'
    },
    {
      icon: $r('app.media.area'),
      text: '面积从小到大',
      orderBy: 'area',
      orderType: 'asc'
    },
    {
      icon: $r('app.media.area'),
      text: '面积从大到小',
      orderBy: 'area',
      orderType: 'desc'
    }
  ]
  @State currentSortType: string = ''
  @State submitOrderType: string = ''
  //显示搜索区域
  showSearchArea = (item: string) => {
    //点击同一个标签需要收起
    if (this.currentSearchText === item) {
      this.isShowSearch = !this.isShowSearch
      this.currentSearchText = ''
    } else {
      this.isShowSearch = true
      this.currentSearchText = item
      this.handleSearchTextChange()
      console.log(JSON.stringify(this.provinceList), '这是省份的数组')
    }
  }
  //隐藏搜索区域
  hideSearchArea = () => {
    this.isShowSearch = false
    this.currentSearchText = ''
    this.currentPaymentWay = ''
    this.currentRantPriceId = 0
    this.currentSortType = ''
  }

  handleSearchTextChange() {
    if (this.currentSearchText === '位置') {
      if (this.submitDistrictName) {
        this.provinceIndex = this.submitProvinceIndex
        this.cityIndex = this.submitCityIndex
        this.districtIndex = this.submitDistrictIndex
      }
      this.getProvinceList()
    } else if (this.currentSearchText === '支付方式') {
      this.currentPaymentWay = this.submitPaymentWay
    } else if (this.currentSearchText === '租金') {
      this.currentRantPriceId = this.submitRantPriceId
    } else if (this.currentSearchText === '排序') {
      this.currentSortType = this.submitOrderType
    }
  }

  @Builder
  positionBuilder() {
    Row() {
      //省份列表
      List() {
        ForEach(this.provinceList, (province: IProvinceItem) => {
          ListItem() {
            Text(province.name)
              .width('100%')
              .height(rvp(30))
              .padding({ left: rvp(PADDING) })
              .fontWeight(500)
              .fontSize(rvp(12))
              .fontColor(this.provinceIndex === province.code ? '#53B99D' : Color.Black)
          }
          .onClick(() => {
            this.provinceIndex = province.code
            this.cityIndex = ''
            this.districtIndex = ''
            this.getCityList()
          })
        }, (province: IProvinceItem) => province.code)
      }
      .width(rvp(120))
      .height(rvp(240))
      .backgroundColor('rgba(247, 247, 247, 1)')
      .scrollBarColor(Color.Transparent)

      //市列表
      List() {
        ForEach(this.cityList, (city: ICityItem) => {
          ListItem() {
            Text(city.name)
              .width('100%')
              .height(rvp(30))
              .padding({ left: rvp(PADDING) })
              .fontWeight(500)
              .fontSize(rvp(12))
              .fontColor(this.cityIndex === city.code ? '#53B99D' : Color.Black)
          }
          .onClick(() => {
            this.cityIndex = city.code
            this.districtIndex = ''
            this.getDistrictList()
          })

        }, (city: ICityItem) => city.code)
      }
      .width(rvp(120))
      .height(rvp(240))
      .backgroundColor('rgba(235, 235, 235, 1)')
      .scrollBarColor(Color.Transparent)

      //区列表
      List() {
        ForEach(this.districtList, (district: IDistrictItem) => {
          ListItem() {
            Text(district.name)
              .width('100%')
              .height(rvp(30))
              .padding({ left: rvp(PADDING) })
              .fontWeight(500)
              .fontSize(rvp(12))
              .fontColor(this.districtIndex === district.code ? '#53B99D' : Color.Black)
          }
          .onClick(() => {
            this.districtIndex = district.code
            console.log('点击的区', this.districtIndex)
          })

        }, (district: IDistrictItem) => district.code)
      }
      .width(rvp(120))
      .height(rvp(240))
      .backgroundColor('rgba(230, 230, 230, 1)')
      .scrollBarColor(Color.Transparent)
    }

    //按钮组
    this.buttonsBuilder(this.resetSearchPosition, this.findRoomByPosition)

  }

  resetSearchPosition = () => {
    this.provinceIndex = this.provinceList[0].code
    this.cityIndex = ''
    this.districtIndex = ''
    this.getCityList()
  }
  findRoomByPosition = () => {
    //this.submitDistrictName = this.districtList.find(district => district.code = this.districtIndex)!.name
    for (let i = 0; i < this.districtList.length; i++) {
      console.log('循环中的内容', this.districtList[i].code, this.districtList[i].name)
      if (this.districtList[i].code === this.districtIndex) {
        this.submitDistrictName = this.districtList[i].name
        this.submitProvinceIndex = this.provinceIndex
        this.submitCityIndex = this.cityIndex
        this.submitDistrictIndex = this.districtIndex
        const searchOption: Partial<ISearchListParams> = {
          provinceCode: this.provinceIndex,
          cityCode: this.cityIndex,
          districtCode: this.districtIndex
        }
        this.hideSearchArea()
        globalEmitter.emit('search', searchOption)
        return
      }
    }
    console.log('选中的市', JSON.stringify(this.districtList))
    console.log('选中的区名', this.submitDistrictName)
  }

  @Builder
  paymentBuilder() {
    Row() {
      ForEach(this.paymentWayList, (payment: string) => {
        Button(payment)
          .backgroundColor(this.currentPaymentWay === payment ? 'rgba(103, 192, 168, 1)' : 'rgba(247, 247, 247, 1)')
          .fontColor(this.currentPaymentWay === payment ? Color.White : 'rgba(102, 102, 102, 1)')
          .fontWeight(500)
          .fontSize(rvp(12))
          .width(rvp(70))
          .height(rvp(26))
          .border({ radius: rvp(4) })
          .type(ButtonType.Normal)
          .onClick(() => {
            this.currentPaymentWay = payment
            console.log('这是支付方式的内容', this.currentPaymentWay)
          })
      })
    }
    .width('100%')
    .padding(rvp(16))
    .justifyContent(FlexAlign.SpaceBetween)

    //按钮组
    this.buttonsBuilder(this.resetSearchPayment, this.findRoomByPaymentWay)
  }

  resetSearchPayment = () => {
    this.currentPaymentWay = ''
  }
  findRoomByPaymentWay = () => {
    this.submitPaymentWay = this.currentPaymentWay
    const searchOption: Partial<ISearchListParams> = { paymentType: this.currentPaymentWay }
    globalEmitter.emit('search', searchOption)
    this.hideSearchArea()
  }

  @Builder
  rantBuilder() {
    Grid() {
      ForEach(this.rantTypeList, (item: IRantPrice) => {
        GridItem() {
          Button(item.text)
            .width(rvp(95))
            .height(rvp(26))
            .type(ButtonType.Normal)
            .border({ radius: rvp(4) })
            .backgroundColor(this.currentRantPriceId === item.id ? 'rgba(103, 192, 168, 1)' : 'rgba(247, 247, 247, 1)')
            .fontColor(this.currentRantPriceId === item.id ? 'rgba(255, 255, 255, 1)' : 'rgba(102, 102, 102, 1)')
            .onClick(() => {
              this.currentRantPriceId = item.id
            })
            .fontSize(rvp(12))
        }
      }, (item: IRantPrice) => item.text)
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr')
    .rowsGap(rvp(8))
    .height(rvp(136))

    this.buttonsBuilder(this.resetSearchRant, this.findRoomByRant)
  }

  resetSearchRant = () => {
    this.currentRantPriceId = 0
  }
  findRoomByRant = () => {
    this.submitRantPriceId = this.currentRantPriceId
    const maxRantPrice = this.rantTypeList.find(item => item.id === this.submitRantPriceId)?.maxRent
    const minRantPrice = this.rantTypeList.find(item => item.id === this.submitRantPriceId)?.minRent
    const searchOption: Partial<ISearchListParams> = { minRent: minRantPrice, maxRent: maxRantPrice }
    globalEmitter.emit('search', searchOption)
    this.hideSearchArea()
  }

  @Builder
  sortBuilder() {
    Column() {
      ForEach(this.sortList, (sortItem: ISortItem) => {
        Row({ space: rvp(8) }) {
          Image(sortItem.icon)
            .width(rvp(16)).height(rvp(16))
            .fillColor(this.currentSortType === sortItem.text ? 'rgba(103, 192, 168, 1)' : 'rgba(102, 102, 102, 1)')
          Text(sortItem.text)
            .fontColor(this.currentSortType === sortItem.text ? 'rgba(103, 192, 168, 1)' : 'rgba(102, 102, 102, 1)')
            .fontWeight(500)
            .fontSize(rvp(12))
        }
        .width('100%').height(rvp(34))
        .onClick(() => {
          this.currentSortType = sortItem.text
          console.log('点击时-按照排序搜索', this.currentSortType, sortItem.orderBy, sortItem.orderType)
          this.findRoomBySort(sortItem.orderBy, sortItem.orderType)
        })
      }, (sortItem: ISortItem) => sortItem.text)
    }
    .width('100%').height(rvp(194))
    .padding({ left: rvp(16), bottom: rvp(32), top: rvp(8) })
  }

  findRoomBySort = (orderBy: string, orderType: string) => {
    console.log('按照排序搜索', orderType, orderBy)
    this.submitOrderType = this.currentSortType
    const searchOption: Partial<ISearchListParams> = { orderBy: orderBy, orderType: orderType }
    globalEmitter.emit('search', searchOption)
    this.hideSearchArea()
  }
  getSearchText = (text: string): string => {
    if (text === '位置') {
      return this.submitDistrictName || text
    } else if (text === '支付方式') {
      return this.submitPaymentWay || text
    } else if (text === '租金') {
      const rantTypeText = this.rantTypeList.find(item => item.id === this.submitRantPriceId)?.text
      return rantTypeText || text
    } else if (text === '排序') {
      return this.submitOrderType || text
    } else {
      return text
    }
  }
  getSearchFontColor = (text: string): string => {
    if (text === '位置') {
      return this.submitDistrictName ? '#333333' : 'rgba(103, 192, 168, 1)'
    } else if (text === '支付方式') {
      return this.submitPaymentWay ? '#333333' : 'rgba(103, 192, 168, 1)'
    } else if (text === '租金') {
      const rantTypeText = this.rantTypeList.find(item => item.id === this.submitRantPriceId)?.text
      return this.submitRantPriceId ? '#333333' : 'rgba(103, 192, 168, 1)'
    } else if (text === '排序') {
      return this.submitOrderType ? '#333333' : 'rgba(103, 192, 168, 1)'
    } else {
      return text
    }
  }

  build() {
    Column() {
      Row() {
        ForEach(this.searchTextList, (item: string) => {
          Row({ space: rvp(7) }) {
            Text(this.getSearchText(item))
              .fontColor('#333333')
              .fontWeight(500)
              .fontSize(rvp(14))
              .constraintSize({
                maxWidth: rvp(56)
              })
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Image(this.currentSearchText === item ? $r('app.media.arrow_up_activate') :
            $r('app.media.Frame_down_arrow'))
              .fillColor(this.currentSearchText === item ? '#53B99D' : Color.Black)
              .fillColor('#333333')
              .width(rvp(15))
              .height(rvp(12))
              .margin({ bottom: rvp(6) })
          }
          .onClick(() => {
            this.showSearchArea(item)
          })
        }, (item: string) => item)


      }
      .width('100%')
      .height(rvp(44))
      .padding({ left: rvp(PADDING), right: rvp(PADDING) })
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: rvp(20) })

      if (this.isShowSearch) {
        Column() {
          if (this.currentSearchText === '位置') {
            this.positionBuilder()
          } else if (this.currentSearchText === '支付方式') {
            this.paymentBuilder()
          } else if (this.currentSearchText === '租金') {
            this.rantBuilder()
          } else if (this.currentSearchText === '排序') {
            this.sortBuilder()
          }
        }
        .width('100%').backgroundColor(Color.White)

        Column() {
        }
        .width('100%').backgroundColor('rgba(0, 0, 0, 0.70)').layoutWeight(1)
        .onClick(() => {
          this.hideSearchArea()
        })
      }

    }
  }

  @Builder
  buttonsBuilder(resetFunc: () => void, findFunc: () => void) {
    //按钮区
    Row({ space: rvp(22) }) {
      Button('重置')
        .width(rvp(95))
        .height(rvp(26))
        .fontColor('rgba(102, 102, 102, 1)')
        .backgroundColor('rgba(240, 240, 240, 1)')
        .border({ radius: rvp(4) })
        .fontWeight(500)
        .fontSize(rvp(12))
        .type(ButtonType.Normal)
        .onClick(resetFunc)
      Button('查看房源')
        .width(rvp(211))
        .height(rvp(26))
        .backgroundColor('rgba(103, 192, 168, 1)')
        .fontColor('rgba(255, 255, 255, 1)')
        .border({ radius: rvp(4) })
        .fontWeight(500)
        .fontSize(rvp(12))
        .type(ButtonType.Normal)
        .onClick(findFunc)
    }
    .height(rvp(58))
    .width('100%')
    .padding(rvp(PADDING))
  }
}