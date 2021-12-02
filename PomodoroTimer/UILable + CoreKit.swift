//
//  UILable + CoreKit.swift
//  PomodoroTimer
//
//  Created by Евгений Ганусенко on 11/22/21.
//

import Foundation
import UIKit

//MARK: - CreateTimerFormat
extension ViewController {

     func setTimerLabel() {
        let countMinutes = Int(floor(Double(durationTimer) / 60))
        let countSecond = durationTimer - (countMinutes * 60)
        var minuteString = String(countMinutes)
        var secondString = String(countSecond)

        if (countMinutes < 10) {
            minuteString = "0" + minuteString
        }

        if (countSecond < 10) {
            secondString = "0" + secondString
        }

        timerLable.text = minuteString + ":" + secondString
    }
}
