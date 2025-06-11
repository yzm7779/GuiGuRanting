import { IndexNavBar } from '../../components/NavBar/IndexNavBar'
import rvp from '../../utils/responsive'
import { router } from '@kit.ArkUI'
import { getLoginCodeApi, loginApi } from '../../api/Login'

interface IParams {
  phone: string
}

PersistentStorage.persistProp('token', '')

@Entry
@Component
struct LoginCode {
  @StorageLink('token') token: string = ''
  START_TIME = 61
  @State second: number = this.START_TIME
  timer = 0
  @State loginCode: string = ''
  @State phone: string = ''
  login = async () => {
    const res = await loginApi(this.phone, this.loginCode)
    this.token = res.iToken
    console.log('这是token', res.iToken)
    router.replaceUrl({
      url: 'pages/Index'
    })
  }
  sendSMSCode = () => {
    getLoginCodeApi(this.phone)
    this.countDown()
  }
  countDown = () => {
    this.second--
    this.timer = setInterval(() => {
      this.second--
      if (this.second <= 0) {
        this.second = this.START_TIME
        clearInterval(this.timer)
      }
    }, 1000)
  }
  handleCodeChange = (val: string) => {
    this.loginCode = val
  }

  aboutToAppear(): void {
    const params = router.getParams() as IParams
    this.phone = params.phone
    this.sendSMSCode()
  }

  aboutToDisappear() {
    clearInterval(this.timer)
  }

  build() {
    Column() {
      IndexNavBar({
        title: '验证码登录'
      })
        .margin({ bottom: rvp(36) })
      Column() {
        Stack() {
          TextInput({ placeholder: '请输入验证码' })
            .onChange((val) => {
              this.handleCodeChange(val)
            })
            .maxLength(11)
            .width('100%')
            .height(rvp(38))
            .border({
              width: { bottom: rvp(1) },
              color: 'rgba(196, 237, 206, 1)',
              radius: 0
            })
            .backgroundColor(Color.Transparent)
            .placeholderColor('rgba(193, 193, 193, 1)')
            .fontSize(rvp(16))
            .padding({ left: 0, right: 0 })
            .caretColor('#DEFBE5')
            .type(InputType.Number)
            .placeholderFont({
              size: rvp(16)
            })
          if (this.second <= this.START_TIME) {
            Text(`${this.second.toString()}s`)
              .fontWeight(500).fontColor('rgba(54, 209, 161, 1)').fontSize(rvp(16))
          } else {
            Text('重新发送')
              .fontWeight(500).fontColor('rgba(54, 209, 161, 1)').fontSize(rvp(16))
              .onClick(() => {
                this.sendSMSCode()
              })
          }

        }
        .width('100%').alignContent(Alignment.End)

        Row() {
          Button('确认')
            .width(rvp(100))
            .height(rvp(40))
            .backgroundColor(this.loginCode.length === 6 ? 'rgba(54, 209, 161, 1)' : 'rgba(240, 240, 240, 1)')
            .fontColor(this.loginCode.length === 6 ? 'rgba(255, 255, 255, 1)' : 'rgba(193, 193, 193, 1)')
            .fontWeight(500)
            .fontSize(rvp(14))
            .stateEffect(false)
            .onClick(() => {
              if (this.loginCode.length === 6) {
                this.login()
              }
            })
        }
        .justifyContent(FlexAlign.End)
        .width('100%')
        .margin({ top: rvp(40) })
      }
      .width('100%')
      .padding({ left: rvp(37), right: rvp(37) })

    }
    .width('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#DEFBE5', 0], ['#FFFFFF', 0.2]]
    })
  }
}