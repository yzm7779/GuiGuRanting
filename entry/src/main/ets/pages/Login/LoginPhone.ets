import { IndexNavBar } from '../../components/NavBar/IndexNavBar'
import rvp from '../../utils/responsive'
import { router } from '@kit.ArkUI'


@Entry
@Component
struct LoginPhone {
  phoneReg = /^1[3-9][0-9]{9}$/
  @State isChecked: boolean = false
  @State isValidPhone: boolean = false
  @State phone: string = ''
  handlePhoneChange = (val: string) => {
    this.phone = val
    if (this.phone.length === 11 && this.phoneReg.test(this.phone)) {
      this.isValidPhone = true
    } else {
      this.isValidPhone = false
    }
  }

  build() {
    Column() {
      IndexNavBar({
        title: '验证码登录'
      })
        .margin({ bottom: rvp(36) })
      Column() {
        Stack() {
          TextInput({ placeholder: '请输入手机号' })
            .onChange((val) => {
              this.handlePhoneChange(val)
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
            .type(InputType.PhoneNumber)
            .placeholderFont({
              size: rvp(16)
            })
          if (this.isValidPhone) {
            Image($r('app.media.vector'))
              .width(rvp(12)).height(rvp(8)).fillColor('rgba(54, 209, 161, 1)')
          }
        }
        .width('100%').alignContent(Alignment.End)

        Row({ space: rvp(6) }) {
          Radio({ value: 'false', group: 'phone' })
            .radioStyle({
              checkedBackgroundColor: 'rgba(54, 209, 161, 1)'
            })
            .checked(this.isChecked)
            .width(rvp(14))
            .height(rvp(14))
            .onClick(() => {
              this.isChecked = !this.isChecked
            })
          Text() {
            Span('同意')
              .fontColor('rgba(193, 193, 193, 1)')
            Span('《用户协议》')
              .fontColor('rgba(54, 209, 161, 1)')
            Span('和')
              .fontColor('rgba(193, 193, 193, 1)')
            Span('《隐私政策》')
              .fontColor('rgba(54, 209, 161, 1)')
          }
          .fontSize(rvp(14)).fontWeight(500)
        }
        .margin({ top: rvp(16) })
        .width('100%')

        Row() {
          Button('获取验证码')
            .width(rvp(100))
            .height(rvp(40))
            .backgroundColor(this.isChecked && this.isValidPhone ? 'rgba(54, 209, 161, 1)' : 'rgba(240, 240, 240, 1)')
            .fontColor('rgba(255, 255, 255, 1)')
            .fontWeight(500)
            .fontSize(rvp(14))
            .stateEffect(false)
            .fontColor(this.isChecked && this.isValidPhone ? Color.White : 'rgba(193, 193, 193, 1)')
            .onClick(() => {
              if (this.isChecked && this.isValidPhone) {
                router.pushUrl({
                  url: 'pages/Login/LoginCode',
                  params: {
                    phone: this.phone
                  }
                })
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