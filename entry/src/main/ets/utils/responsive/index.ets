const DRAFT_WIDTH = 360

export default function rvp(val: number) {
  /*
  计算元素真正的大小
   */

  return val / DRAFT_WIDTH * (AppStorage.get('windowWidth') as number)
}