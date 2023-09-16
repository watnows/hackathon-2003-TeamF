//
//  FetchAccelerationInfo.swift
//  SafeDriving
//
//  Created by 澤木柊斗 on 2023/09/16.
//

import Foundation
import UIKit
import CoreMotion

class MotionSensor: NSObject, ObservableObject {
  @Published var isStarted = false
    @Published var xStr = "0"
    @Published var yStr = "0"
    @Published var zStr = "0"
    
  let motionManager = CMMotionManager()
  func start() {
    if motionManager.isDeviceMotionAvailable {
      motionManager.deviceMotionUpdateInterval = 0.1
      motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
        self.updateMotionData(deviceMotion: motion!)
      })
    }
    isStarted = true
  }
  func stop() {
    isStarted = false
    motionManager.stopDeviceMotionUpdates()
  }
  private func updateMotionData(deviceMotion:CMDeviceMotion) {
    xStr = String(deviceMotion.userAcceleration.x)
    yStr = String(deviceMotion.userAcceleration.y)
    zStr = String(deviceMotion.userAcceleration.z)
  }
}
