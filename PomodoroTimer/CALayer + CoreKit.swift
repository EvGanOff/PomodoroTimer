//
//  CALayer + CoreKit.swift
//  PomodoroTimer
//
//  Created by Евгений Ганусенко on 12/2/21.
//

import Foundation
import UIKit
extension CALayer {
    func pausedAnimation() {
        if isPaused() == false {
            let pause = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pause
        }
    }

    func startAnimation() {
        if isPaused() {
            let pause = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pause
            beginTime = timeSincePause
        }
    }

    func isPaused() -> Bool {
        return speed == 0
    }
}
