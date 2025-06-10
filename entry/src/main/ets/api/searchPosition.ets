import { ICityList, IDistrictList, IProvinceList } from '../modules/ReaearchRoomList'
import { http } from '../utils/http'

//获取省份数据
export const getSearchPositionProvinceApi = (): Promise<IProvinceList> => {
  return http.get<IProvinceList>('/province')
}

//按照省份获得市数据
export const getSearchPositionCityApi = (provinceCode: string): Promise<ICityList> => {
  return http.get<ICityList>('/city', { provinceCode })
}

//按照省市数据获得区数据
export const getSearchPositionDistrictApi = (cityCode: string): Promise<IDistrictList> => {
  return http.get<IDistrictList>('/area', { cityCode })
}
