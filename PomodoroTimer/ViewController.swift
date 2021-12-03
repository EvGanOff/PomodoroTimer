//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Евгений Ганусенко on 11/19/21.
//

import UIKit


class ViewController: UIViewController {
    var timer = Timer()
    var durationTimer: Int = 0
    let shapeGreyLayer = CAShapeLayer()
    let shapeProgressLayer = CAShapeLayer()
    var pausedTime: CFTimeInterval?
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    var isTapButton: Bool = false
    var isBreak = false

    var pulseLayer = CAShapeLayer()

    //MARK: - CreateUI
    var timerLable: UILabel = {
        let lable = UILabel()
        var countSecond: Int = 0
        var countMinutes: Int = 0
        lable.text = "0\(countMinutes) : 0\(countSecond)"
        lable.font = UIFont.boldSystemFont(ofSize: 60)
        lable.textColor = .systemPink
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    let circleBar: UIView = {
        let circle = UIView()
        let shapeLayer = CAShapeLayer()
        circle.layer.addSublayer(shapeLayer)
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()

    var circleProgressBar: UIView = {
        let circle = UIView()
        let shapeLayer = CAShapeLayer()
        circle.layer.addSublayer(shapeLayer)
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()

    var circleGradientProgressBar: UIView = {
        let circle = UIView()
        let shapeLayer = CAShapeLayer()
        circle.layer.addSublayer(shapeLayer)
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()

    var startButton: UIButton = {
        let startButton = UIButton(frame: CGRect(x: 280, y: 450, width: -150, height: 50))
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = .systemPink
        startButton.layer.cornerRadius = 25
        startButton.tintColor = .systemPink
        return startButton
    }()

    //MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.drawPulsatingLayer()
        self.createdGreyBar()
        self.createdPinkBar()

    }
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        animatePulse()
    }

    //MARK: - CreateTimerAction
    @objc func timerAction() {
        durationTimer = durationTimer - 1
        setTimerLabel()
        workOrBreak()
        isTapButton = true
    }

    //MARK: - ButtonAction
    func workOrBreak() {
        if durationTimer <= 0 && isBreak != true {
            if durationTimer == 0 {
                resetProgressBar()
            }
            durationTimer = 10
            startButton.setTitle("Start", for: .normal)
            shapeProgressLayer.pausedAnimation()
            timer.invalidate()
            timerLable.textColor = .systemPink
            startButton.backgroundColor = .systemPink
            shapeProgressLayer.strokeColor = UIColor.systemPink.cgColor
            animateCircle()
            animatePulse()
            timerLable.text = ("00:10")
            isBreak = true
        }

        if durationTimer <= 0 && isBreak != false {
            if durationTimer == 0 {
                resetProgressBar()
                shapeProgressLayer.strokeColor = UIColor.systemGreen.cgColor
            }
            shapeProgressLayer.strokeColor = UIColor.systemGreen.cgColor
            startButton.setTitle("Start", for: .normal)
            durationTimer = 5
            shapeProgressLayer.pausedAnimation()
            timer.invalidate()
            timerLable.textColor = .systemGreen
            startButton.backgroundColor = .systemGreen
            animateCircle()
            timerLable.text = ("00:05")
            isBreak = false
        }

    }

    
    //MARK: - TapButtonAction
    @objc func didTapStartButton() {
        if isTapButton {
            if shapeProgressLayer.isPaused() {
                shapeProgressLayer.startAnimation()
                startButton.setTitle("Pause", for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            } else {
                shapeProgressLayer.pausedAnimation()
                startButton.setTitle("Start", for: .normal)
                timer.invalidate()
            }
        } else {
            if shapeProgressLayer.isPaused() {
                startButton.setTitle("Start", for: .normal)
            } else {
                startButton.setTitle("Pause", for: .normal)
            }
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
}

//MARK: - Constraints
extension ViewController {
    func setConstraints() {

        view.addSubview(circleBar)
        NSLayoutConstraint.activate([
            circleBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleBar.heightAnchor.constraint(equalToConstant: 300),
            circleBar.widthAnchor.constraint(equalToConstant: 300)
            ])

        view.addSubview(circleProgressBar)
        view.addSubview(circleGradientProgressBar)
        NSLayoutConstraint.activate([
            circleProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleProgressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleProgressBar.heightAnchor.constraint(equalToConstant: 300),
            circleProgressBar.widthAnchor.constraint(equalToConstant: 300),
            circleGradientProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleGradientProgressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleGradientProgressBar.heightAnchor.constraint(equalToConstant: 300),
            circleGradientProgressBar.widthAnchor.constraint(equalToConstant: 300)
            ])

        view.addSubview(timerLable)
        NSLayoutConstraint.activate([
            timerLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            timerLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
    }

}
