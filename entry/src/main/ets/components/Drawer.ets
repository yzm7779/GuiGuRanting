@Component
export struct bookDrawer {
  @Link visible: boolean
  @BuilderParam contentBuilderParam: () => void = this.customBuilder
  @Require @Prop drawerHeight: number

  @Builder
  customBuilder() {
  }

  close = () => {
    this.visible = false
  }

  build() {
    if (this.visible) {
      Stack() {
        Column() {
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.70)')
        .onClick(() => {
          this.close()
        })
        .transition(TransitionEffect.OPACITY.animation({ duration: 1000, curve: Curve.Linear }))

        Column() {
          this.contentBuilderParam()
        }
        .width('100%')
        .padding(16)
        .backgroundColor('rgba(246, 246, 246, 1)')
        .border({
          radius: { topLeft: 16, topRight: 16 }
        })
        .transition(TransitionEffect.translate({
          x: 0, y: this.drawerHeight
        }).animation({ duration: 1000 }))

      }
      .width('100%').height('100%')
      .alignContent(Alignment.Bottom)
    }


  }
}