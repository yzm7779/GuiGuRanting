import { IRantRoomItem, IRentRoomDetail } from "../modules/RantRoomDetailData"
import { http } from "../utils/http"

//获取房源详细信息
export const getRoomDetailApi = (id: string): Promise<IRentRoomDetail> => {
  return http.get<IRentRoomDetail>('/house/detail', { id })
}


export const rantRoomApi = (data: IRantRoomItem): Promise<null> => {
  return http.post<null>('/auth/house/reservation', data)
}