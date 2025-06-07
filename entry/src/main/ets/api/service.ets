import { IServiceData } from "../modules/ServiceData"
import { http } from "../utils/http"

//获取服务页信息数据
export const getServiceDataApi = (): Promise<IServiceData> => {
  return http.get<IServiceData>('/service/info')
}