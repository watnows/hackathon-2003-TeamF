//
//  ContentView.swift
//  SafeDriving
//
//  Created by 中川真一 on 2023/09/16.
//

import SwiftUI
import UIKit
import CoreMotion
import SwiftUI
struct ContentView: View {
  @ObservedObject var sensor = MotionSensor()
  var body: some View {
    VStack {
      Text(sensor.xStr)
      Text(sensor.yStr)
      Text(sensor.zStr)
      Button(action: {
        self.sensor.isStarted ? self.sensor.stop() : self.sensor.start()
      }) {
        self.sensor.isStarted ? Text("STOP") : Text("START")
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
