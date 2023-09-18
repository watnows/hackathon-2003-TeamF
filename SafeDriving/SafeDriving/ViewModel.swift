//
//  FetchAccelerationInfo.swift
//  SafeDriving
//
//  Created by 澤木柊斗 on 2023/09/16.
//

import CoreMotion

class MotionSensor: ObservableObject {
    @Published var zAcceleration: Double = 0.0
    @Published var extimerCount: Double = 0.0
       private var timer: Timer?
    @Published var midExtimerCount: Double = 0.0
       private var midtimer: Timer?
    private let motionManager = CMMotionManager()



    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                if let accelerationData = data?.acceleration {
                    self.zAcceleration = accelerationData.y
                    if self.zAcceleration < -0.4 {
                        if self.timer == nil {
                            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                                self?.extimerCount += 0.1
                                   }
                               }
                    } else {
                        self.timer?.invalidate()
                        self.timer = nil
                        }
                    if self.zAcceleration < -0.3 && self.zAcceleration > -0.4{
                        if self.midtimer == nil {
                            self.midtimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                                self?.midExtimerCount += 0.1
                                   }
                               }
                    } else {
                        self.midtimer?.invalidate()
                        self.midtimer = nil
                        }
                }
            }
        }
    }

    func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
        self.midtimer?.invalidate()
        self.midtimer = nil
        self.timer?.invalidate()
        self.timer = nil

    }

}
