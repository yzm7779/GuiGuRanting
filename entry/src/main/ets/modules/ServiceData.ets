export interface IServiceData {
  "vipServiceList": IVipServiceItem[],
  "homeServiceList": IHomeServiceItem[],
  "serviceActivity": IServiceActivity,
  "newcomerZone": INewComerZero,
  "cleaningServiceInfo": ICleaningServiceInfo[]
}

export interface IVipServiceItem {
  "name": string,
  "content": number
}

export interface IHomeServiceItem {
  "icon": string,
  "title": string
}

export interface IServiceActivity {
  "name": string,
  "img": string,
  "title": string,
  "subTitle": string
}

export interface INewComerZero {
  "img": string
}

export interface ICleaningServiceInfo {
  "img": string,
  "title": string,
  "subTitle": string,
  "originalPrice": string,
  "priceAfterDiscounts": string
}

export type IVipServiceList = IVipServiceItem[]

export type IHomeServiceList = IHomeServiceItem[]

export type ICleaningServiceInfoList = ICleaningServiceInfo[]
