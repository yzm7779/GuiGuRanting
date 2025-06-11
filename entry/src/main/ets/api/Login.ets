import { http } from "../utils/http"

interface IResponse {
  iToken: string
}

//获取房源详细信息
export const getLoginCodeApi = (phone: string): Promise<null> => {
  return http.post<null>('/sendSMSCode', { phone })
}

export const loginApi = (phone: string, code: string): Promise<IResponse> => {
  return http.post<IResponse>('/login', { phone, code })
}