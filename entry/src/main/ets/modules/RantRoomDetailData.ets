import { IRoomRecommendItem } from "./HomeData"

export interface IHousePictureItem {
  "spaceName": string
  "picList": string[]
}

export type IHousePictureList = IHousePictureItem[]

export interface IDistanceInfo {
  "distance": string
  "line": string
  "name": string
}

export interface IRentTerm {
  "checkInTime": string
  "term": string
  "kitchen": string
  "lift": string
  "seeTime": string
  "year": string
  "renovation": string
  "grounding": string
  "heating": string
  "green": string
  "protection": string
  "house": string
}

export interface IMetaInfoItem {
  "name": string
  "desc": string
}

export type IMetaInfoList = IMetaInfoItem[]

export interface IDiscountsItem {
  "tagTxtBgAroundColor": string
  "image": string
  "txt": string
  "tagTxt": string
  "tagTxtColor": string
}

export type IDiscountsList = IDiscountsItem[]

export interface IItem {
  "icon": string
  "value": string
}

export type IItemList = IItem[]

export interface IHouseholdItem {
  "name": string
  "itemList": IItemList
}

export type IHouseholdList = IHouseholdItem[]

export interface ISupportItem {
  "image": string
  "title": string
  "subTitle": string
}

export type ISupportList = ISupportItem[]

export interface IRentInfoItem {
  "image": string
  "title": string
  "userTag": string
}

export type IRentInfoList = IRentInfoItem[]

export interface IRentRoomDetail extends Omit<IRoomRecommendItem, 'housePicture'> {
  "housePicture": IHousePictureList
  "distanceInfo": IDistanceInfo
  "rentTerm": IRentTerm
  "metaInfo": IMetaInfoList
  "discounts": IDiscountsList
  "householdItem": IHouseholdList
  "support": ISupportList
  "rentInfo": IRentInfoList
  "rentPriceUnitListing": string
}

export interface IParam {
  id: string
}

export interface IRoomType {
  name: string
  total: number
}

export type IRoomTypeList = IRoomType[]

export interface IRantRoomItem {
  "name": string,
  "date": string,
  "houseId": string,
  "phone": string,
  "comment": string
}
