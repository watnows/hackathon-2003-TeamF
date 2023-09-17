import SwiftUI
import CoreMotion
struct ContentView: View {
  enum Pattern {
    case safe
    case mid
    case out
    var rotatedeg: Int {
      switch self {
      case .safe: return 0
      case .mid: return 45
      case .out: return 90
      }
    }
    var alartState: String {
      switch self{
      case .safe: return "いい調子！"
      case .mid: return "ちょっと不快！"
      case .out: return "最悪！！"
      }
    }
    var backgroundColor: Color {
      switch self{
      case .safe: return .cyan
      case .mid: return .yellow
      case .out: return .red
      }
    }
  }
  @State private var isShowFullScreen = false
  @State var count: Double = 0.0
  @State var excount: Double = 0.0
  @State var timer: Timer?
  @State var extimer: Timer?
  @State var isMeasuring: Bool = false
  @ObservedObject var sensor = MotionSensor()
  var pattern: Pattern {
    if sensor.zAcceleration < -0.4 {
      return .out
    } else if sensor.zAcceleration <= -0.3 && sensor.zAcceleration >= -0.4 {
      return .mid
    } else {
      return .safe
    }
  }
  var body: some View {
    VStack {
      VStack{
        Text(pattern.alartState)
          .font(.system(size: 30))
          .foregroundColor(sensor.zAcceleration > -0.4 ? .black : .white)
          .fontWeight(.black)
        Text(String(floor(sensor.zAcceleration
                 * 100)/100) + "G")
        .padding(.bottom,10)
        Text("経過時間：\(count)秒")
          .padding(.bottom,4)
        Text("0.4G以上：\(sensor.extimerCount)秒")
          .padding(.bottom,4)
          .foregroundColor(.white)
          .fontWeight(.bold)
        Text("0.2G以上：\(sensor.midExtimerCount)秒")
          .fontWeight(.bold)
      }
      .frame(maxWidth: .infinity)
      .frame(height: 200)
      .background(pattern.backgroundColor)
      .cornerRadius(20)
      .padding(.horizontal, 30)
      .animation(Animation.easeIn(duration: 0.2), value: pattern.backgroundColor)
      ZStack{
        Image("medicine_cup_water")
          .resizable()
          .scaledToFit()
          .frame(height: 300)
          .rotationEffect(.degrees(Double(pattern.rotatedeg)))
          .animation(.linear, value: pattern.rotatedeg)
      }
      SwiftUI.Button(action: {
        // 計測を開始または停止
        if isMeasuring {
          sensor.stopAccelerometerUpdates()
          timer?.invalidate()
          sensor.zAcceleration = 0.0
        } else {
          sensor.startAccelerometerUpdates()
          timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.count += 0.1
          }
        }
        self.isMeasuring.toggle()
        print("tap")
        // 計測状態を切り替える
      }) {
        Button
      }
      .fullScreenCover(isPresented: $isShowFullScreen) {
        Result(excount: sensor.extimerCount,midexcount: sensor.midExtimerCount)
      }
      .onChange(of: isMeasuring, perform: { newValue in
        if newValue == false {
          self.isShowFullScreen = true
          print(excount)
        }
      })
      SwiftUI.Button{sensor.extimerCount = 0.0
        sensor.midExtimerCount = 0.0
        count = 0
      } label:{
        Text("リセット")
      }
      .padding(.top, 20)
    }
    .frame(maxWidth: .infinity)
    .padding(.bottom, 100)
    .background(Image("inside")
      .resizable()
      .scaledToFill()
      .frame(height: 1000)
      .padding(.top, 200))
  }
}
private extension ContentView {
  var Button: some View {
    HStack{
      if isMeasuring == false {
        Text("測定開始")
          .foregroundColor(.white)
          .fontWeight(.black)
          .font(.system(size: 20))
          .frame(width: 120,height: 60)
      } else {
        Text("測定終了")
          .foregroundColor(.white)
          .fontWeight(.black)
          .font(.system(size: 20))
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .cornerRadius(0)
      }
    }
    .background(isMeasuring ? .red: .blue)
    .cornerRadius(30)
    .shadow(radius: 15)
    .animation(Animation.easeIn(duration: 0.2),
          value: isMeasuring
    )  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
