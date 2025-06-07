import { IndexNavBar } from '../../components/NavBar/IndexNavBar';
import { SearchFilter } from '../../views/RantRoomList/SearchFilter';


@Entry
@Component
struct RantRoomList {
  @State message: string = 'Hello World';

  build() {
    Column() {
      IndexNavBar({ title: '房源推荐' })
      SearchFilter()
    }
    .width('100%')
    .height('100%')
  }
}