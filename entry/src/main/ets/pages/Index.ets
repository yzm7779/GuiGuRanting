import { HomePage } from './HomePage'
import { DiscoverPage } from './DiscoverPage'
import { MinePage } from './MinePage'
import { SeePage } from './SeePage'
import { ServicePage } from './ServicePage'
import rvp from '../utils/responsive'
import { window } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct Index {
  @State currentTabBarIndex: number = 0
  @StorageProp('bottomHeight') bottomHeight: number = 0
  setNavBarColor = async (color: string) => {
    const windowClass = await window.getLastWindow(getContext(this) as common.BaseContext)
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: `${color}`
    })
  }

  @Builder
  tabBarBuilder(image: Resource, activeImage: Resource, text: string, index: number) {
    Column() {
      Image(this.currentTabBarIndex === index ? activeImage : image)
        .width(rvp(28)).height(rvp(28))
      Text(text)
        .fontSize(rvp(10)).fontColor(this.currentTabBarIndex === index ? Color.Black : '#A0A0A0')
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      //首页
      TabContent() {
        HomePage()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_home'), $r('app.media.tabbar_home_active'), '首页', 0))

      //想看
      TabContent() {
        SeePage()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_see'), $r('app.media.tabbar_see_active'), '想看', 1))

      //服务
      TabContent() {
        ServicePage()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_service'), $r('app.media.tabbar_service_active'), '服务', 2))

      //发现
      TabContent() {
        DiscoverPage()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active'), '发现', 3))

      //我的
      TabContent() {
        MinePage()
      }.tabBar(this.tabBarBuilder($r('app.media.tabbar_my'), $r('app.media.tabbar_my_active'), '我的', 4))
    }
    .barHeight(rvp(50) + this.bottomHeight)
    .scrollable(false)
    .onChange((index: number) => {
      this.currentTabBarIndex = index
      if (index === 1) {
        this.setNavBarColor('#000000')
      } else {
        this.setNavBarColor('#FFFFFF')
      }
    })
  }
}