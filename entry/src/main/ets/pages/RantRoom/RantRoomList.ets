import { IndexNavBar } from '../../components/NavBar/IndexNavBar';
import rvp from '../../utils/responsive';
import { RoomList } from '../../views/RantRoomList/RoomList';
import { SearchFilter } from '../../views/RantRoomList/SearchFilter';


@Entry
@Component
struct RantRoomList {
  @State message: string = 'Hello World';

  build() {
    Stack() {
      IndexNavBar({ title: '房源推荐' })
      SearchFilter()
        .padding({ top: rvp(44) }).zIndex(10)
      RoomList()
        .padding({ top: rvp(100) })
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.TopStart)
  }
}