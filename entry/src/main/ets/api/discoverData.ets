import { ISearchListParams, ISearchRoomListData } from "../modules/ReaearchRoomList"
import { http } from "../utils/http"

export const searchHomeListApi = (params: ISearchListParams): Promise<ISearchRoomListData> => {
  return http.get<ISearchRoomListData>('/house/search', params)
}