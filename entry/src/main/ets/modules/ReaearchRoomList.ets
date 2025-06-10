import { IRoomRecommendItem } from "./HomeData"

export interface ISearchListParams {
  page: number
  limit: number
  provinceCode?: string
  cityCode?: string
  districtCode?: string
  minRent?: string
  maxRent?: string
  paymentType?: string
  orderBy?: string
  orderType?: string
}

export interface IActivity {
  "title": string,
  "textColor": string,
  "textBackGroundColor": string,
  "#text": string,
  "icon": string
}

export interface IRoomItem extends IRoomRecommendItem {
  activity?: IActivity
}

export type IRoomList = IRoomItem[]

export interface ISearchRoomListData {
  records: IRoomList,
  total: string
}

export class RoomDataSource implements IDataSource {
  listeners: DataChangeListener[] = []
  roomList: IRoomList = []

  // constructor(roomList: IRoomList) {
  //   this.roomList = roomList;
  // }

  getData(index: number) {
    return this.roomList[index];
  }

  totalCount() {
    return this.roomList.length;
  }

  //更新全部数据
  setList(list: IRoomList) {
    this.roomList = list
    this.notifyDataReload()
  }

  //追加数据
  pushList(list: IRoomList) {
    list.forEach(item => {
      this.roomList.push(item)
      this.notifyDataAdd(this.roomList.length - 1)
    })
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }
}

export interface IProvinceItem {
  code: string,
  name: string
}

export type IProvinceList = IProvinceItem[]

export interface ICityItem extends IProvinceItem {
  provinceCode: string
}

export type ICityList = ICityItem[]

export interface IDistrictItem extends ICityItem {
  cityCode: string
}

export type IDistrictList = IDistrictItem[]

export interface ISortItem {
  icon: Resource,
  text: string,
  orderBy: string,
  orderType: string
}

export type ISortItemList = ISortItem[]