import { IHomeData, IRoomRecommendList } from '../modules/HomeData'
import { http } from '../utils/http'

//获取首页数据
export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info')
}

//获取周边房源
export const getHomeRecommendApi = (): Promise<IRoomRecommendList> => {
  return http.get<IRoomRecommendList>('/house/nearbyHouses')
}