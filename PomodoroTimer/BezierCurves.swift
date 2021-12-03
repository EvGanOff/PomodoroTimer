//
//  BezierCurves.swift
//  PomodoroTimer
//
//  Created by Евгений Ганусенко on 11/19/21.
//

import Foundation
import UIKit

//MARK: - CreatedLayers
extension ViewController {
    func createdGreyBar() {
        let centre = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circlePath = UIBezierPath(arcCenter: centre, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeGreyLayer.path = circlePath.cgPath
        shapeGreyLayer.lineWidth = 13
        shapeGreyLayer.fillColor = UIColor.clear.cgColor
        shapeGreyLayer.strokeEnd = 1
        shapeGreyLayer.lineCap = CAShapeLayerLineCap.round
        shapeGreyLayer.strokeColor = UIColor.systemGray3.cgColor
        view.layer.addSublayer(shapeGreyLayer)
    }

    func createdPinkBar() {
        let centre = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circlePath = UIBezierPath(arcCenter: centre, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeProgressLayer.path = circlePath.cgPath
        shapeProgressLayer.lineWidth = 13
        shapeProgressLayer.fillColor = nil
        shapeProgressLayer.strokeEnd = 1
        shapeProgressLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(shapeProgressLayer)
    }
    func drawPulsatingLayer() {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 150, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        pulseLayer.path = circularPath.cgPath
        pulseLayer.lineWidth = 2.0
        pulseLayer.fillColor = UIColor.clear.cgColor
        pulseLayer.strokeColor = #colorLiteral(red: 1, green: 0.6722753644, blue: 0.7758004069, alpha: 0.6973820364).cgColor
        pulseLayer.lineCap = .round
        pulseLayer.position = view.center
        view.layer.addSublayer(pulseLayer)
    }

    //MARK: - CreatedAnimation
    
    func animateCircle() {
        if pausedTime != nil {
            shapeProgressLayer.speed = 1.0
            shapeProgressLayer.timeOffset = 0.0
            shapeProgressLayer.beginTime = 0.0
        } else {
            basicAnimation.toValue = 0
            basicAnimation.duration = CFTimeInterval(durationTimer)
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = false
            shapeProgressLayer.add(basicAnimation, forKey: "basicAnimation")
            view.layer.addSublayer(shapeProgressLayer)
        }
    }

    func animatePulse() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 2.0
        animation.fromValue = 1.0
        animation.toValue = 1.2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        animation.isRemovedOnCompletion = true
        pulseLayer.add(animation, forKey: "scale")
    }

    //MARK: - Reset Progress
    @objc func resetProgressBar() {
        shapeProgressLayer.strokeEnd = 0
        shapeProgressLayer.strokeColor = nil
        shapeProgressLayer.removeAllAnimations()
    }
}
