import { getHomeDataApi } from "../api/home";
import { SwiperLayout } from "../views/HomeViews/SwiperLayout";
import { BannerListDataSource, IBannerList, IColor, INavList, IPlanList, ITitleList } from "../modules/HomeData";
import { SearchBar } from "../views/HomeViews/SearchBar";
import { NavList } from "../views/HomeViews/NavList";
import { PADDING } from "../constants/size";
import { TitleList } from "../views/HomeViews/TitleList";
import { PlanList } from "../views/HomeViews/PlanList";
import { AdPanel } from "../views/HomeViews/AdPanel";
import { RoomRecommend } from "../views/HomeViews/RoomRecommend";
import { IndexScroll } from "../components/ScrollContainer/IndexScroll";
import { window } from "@kit.ArkUI";
import { common } from "@kit.AbilityKit";

@Component
export struct HomePage {
  //轮播图数据
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  //导航列表数据
  @State navList: INavList = []
  //标签列表数据
  @State titleList: ITitleList = []
  //计划列表数据
  @State planList: IPlanList = []
  //图片资源
  @State adPicture: string = ''
  //scroll组件滚动总距离
  scrollY: number = 0
  //计算颜色
  @State bgColor: string = 'rgba(0,0,0,0)'
  @State fontColor: string = 'rgba(255,255,255,1)'
  //透明度
  colorOpacity: number = 0

  //生命周期函数，调用首页的数据
  aboutToAppear(): void {
    this.getHomeData()
  }

  //获取主页数据
  async getHomeData() {
    const result = await getHomeDataApi()
    this.bannerList.setList(result.bannerList)
    this.navList = result.navList
    this.titleList = result.tileList
    this.planList = result.planList
    this.adPicture = result.adPicture
    console.log('主页获得的数据：', JSON.stringify(result))
  }

  //滚动事件
  handleScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset
    console.log('总移动距离', this.scrollY)
    //计算颜色
    this.calcColor()
  }
  calcColor = () => {
    if (this.scrollY < 10) {
      //到达顶部
      this.bgColor = 'rgba(255,255,255,0)'
      this.fontColor = 'rgba(255,255,255,1)'
    } else if (this.scrollY < 100) {
      //渐变中
      this.colorOpacity = (this.scrollY - 10) / 90
      this.bgColor = `rgba(255,255,255,${this.colorOpacity})`
      this.fontColor = `rgba(0,0,0,${this.colorOpacity})`
    } else {
      //渐变全部完成
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = 'rgb(0, 0, 0,1)'
    }
  }

  @Builder
  navBuilder($$: IColor) {
    //顶部搜索栏
    SearchBar({ fontColor: $$.fontColor })
  }

  @Builder
  contentBuilder() {
    //轮播图组件
    SwiperLayout({ bannerList: this.bannerList })

    Column() {
      //导航列表组件
      NavList({ navList: this.navList })
      //标签列表数据
      TitleList({ titleList: this.titleList })
      //计划列表数据
      PlanList({ planList: this.planList })
      //图片组件
      AdPanel({ adPicture: this.adPicture })
    }
    .padding({ left: PADDING, right: PADDING })

    //周边房源
    RoomRecommend()
  }

  build() {
    IndexScroll({
      navBuilderParam: this.navBuilder,
      contentBuilderParam: () => {
        this.contentBuilder()
      }
    })
  }
}