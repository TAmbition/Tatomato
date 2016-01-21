# Tatomato

### 关于 Tatomato

Tatomato 是一个用 Swift 编写的 [番茄工作法](https://zh.wikipedia.org/wiki/%E7%95%AA%E8%8C%84%E5%B7%A5%E4%BD%9C%E6%B3%95) App，计时器参考了 [Pomodoro Timer](https://github.com/megabitsenmzq/PomodoroTimer)。这个小项目从 2015.12.28 开始，基本在业余时间完成，很感谢 [@江南的悲伤](https://github.com/SergioChan) 在遇见奇怪问题时帮我指点迷津。

###  遇见了什么

完成 Tatomato 过程中邂逅了很多未曾细想的问题，在此之前觉得某些功能实现起来简直轻松加愉快，但事实并不是这样的，不是说实现很难，而是在做的过程中，那些细节问题呼之欲出，但我却没真正遇到过：比如计时器在点击「HOME」键或者锁屏后就不运行了；「设置页」完成时间设定后 View 并未同步刷新；如何复用同一个 PickerView...不管怎么样，还是把它弄出来了，这真是一场伟大的冒险。

### 运行模式

默认时间：25 min，短休息：5 min，长时休息：25 min（储存在 NSUserDefaults 中）

模式有 4 种，用 pomoMode 表示：

    pomoMode
        case 0: Stay
        case 1: Work
        case 2: Break
        case 3: LongBreak

点击「Start」开始工作，待工作时间结束后，会自动切换到休息时间，且会有响铃提醒，流程为：**工作 -> 短休息 -> 工作 -> 短休息 -> 工作 -> 短休息 -> 工作 -> 长时休息**

进入「Setting」，可以更换「工作时间」、「休息时间」

### 技术细节
- 使用 CAShapeLayer 和 UIBezierPath 绘制圆弧
- 为 Button 添加不同点击事件，完成后移除相应手势
- PickerView 的使用，配置和 TableView 大同小异（Delegate、Datasource）
- 在 Storyboard 中使用 stackview
- 播放无声音频让 App 在后台继续计时
- 使用 SFSafariViewController 完成网页显示
- 使用 Segue 完成自定义转场动画
- 使用 NSUserDefaults 储存时间设置
- 使用 NSUserLocalNotification 添加本地提醒

### 让人兴奋的时刻
- 解决时间正常显示，圆弧进度实时更新
- 解决 Start 添加 Tap Gesture 后导致的奇怪弹窗问题
- 解决 Setting 页点击不同的 Label 更新不同的 PickerView
- 解决 Setting 页时间更新后，主页时间未实时更新

### 草稿 & 截图
![biu1][1]
![biu2][2]
![MainScreen][4]
![Setting][5]
![About][6]


  [1]: http://static.zybuluo.com/TAmbition/9oa042vyi0sazpdcy1u4zwal/biu1.jpg
  [2]: http://static.zybuluo.com/TAmbition/via97z29k1g79kdc7o3jp618/biu2.jpg
  [4]: http://static.zybuluo.com/TAmbition/klp3g3nye3lb9y6cr6x7wzmf/MainScreen.PNG
  [5]: http://static.zybuluo.com/TAmbition/22s05kke76o45e5t4x57e5bh/Setting.PNG
  [6]: http://static.zybuluo.com/TAmbition/s889yiqszh3nx40nwjxxu63p/About.PNG
  


  
  
  
