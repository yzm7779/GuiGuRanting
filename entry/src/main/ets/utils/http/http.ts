import axios, { InternalAxiosRequestConfig } from '@ohos/axios'
import { promptAction } from '@kit.ArkUI'
import { AnyObject } from '../../modules/Http'

const request = axios.create({
  baseURL: 'http://10.98.157.34:6060'
})

request.interceptors.request.use(
  (config) => {
    //将来添加token参数
    return config
  }
)

request.interceptors.response.use(
  (response) => {
    if (response.headers.code === 200) {
      return response.data.data
    } else {
      //错误提示
      // promptAction.showToast({
      //   message: response.data.message
      // })
      return response.data.data
    }
  },
  (error: Error) => {
    //错误提示
    promptAction.showToast({
      message: error.message
    })
    return Promise.reject(error.message)
  },
)

export class Http {
  get<T>(url: string, params?: AnyObject) {
    return request.get<any, T>(url, { params })
  }

  post<T>(url: string, data?: AnyObject) {
    return request.post<any, T>(url, data)
  }

  put<T>(url: string, data?: AnyObject) {
    return request.put<any, T>(url, data)
  }

  delete<T>(url: string, params?: AnyObject) {
    return request.delete<any, T>(url, { params })
  }
}