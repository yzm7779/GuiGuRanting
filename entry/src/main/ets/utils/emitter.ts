type ICallback = (arg: unknown) => unknown

type ICallbacks = ICallback[]

interface IEvents {
  [key: string]: ICallbacks
}


function createEmitter() {

  //存储自定义事件的容器
  /*
   * 存放自定义事件的容器
   * 容器结构：
   * {
   *    eventName: [回调函数1,回调函数2,回调函数3,...]
   * }
   */
  const events = {}

  return {
    //绑定事件
    //eventName:自定义事件名称，callback：回调函数
    on(eventName: string, callback: ICallback) {
      if (!events[eventName]) {
        events[eventName] = [callback] //第一次添加
      } else {
        events[eventName].push(callback) //第二次及以后添加
      }
    },
    //解绑事件
    off(eventName: string, callback?: ICallback) {
      /*
        off('eventName') 解绑事件eventName的所有回调函数
        off('eventName‘,cb)解绑事件eventName的回调函数cb
       */
      const callbacks = events[eventName]
      if (!callbacks) {
        return
      }
      if (callback) {
        //解绑一个
        events[eventName] = callbacks.filter(cb => cb !== callback)
      } else {
        //解绑所有
        delete events[eventName]
      }
    },
    //触发事件
    //eventName:自定义事件名称，arg:自定义事件回调函数的参数
    emit(eventName: string, arg?: unknown) {
      const callbacks: ICallbacks = events[eventName]
      if (!callbacks) {
        return
      }
      //遍历所有函数，一一更新
      callbacks.forEach(cb => cb(arg))
    }
  }
}


const globalEmitter = createEmitter()

export default globalEmitter