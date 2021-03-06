//
//  ViewController.swift
//  Timer_Animation
//
//  Created by mac on 2022/03/22.
//

import UIKit
import AudioToolbox

enum TimerStatus {
    
    case start
    case pause
    case end
    
}


class ViewController: UIViewController {

    let mainView = View()
    
    var duration = 60
    var timerStatus : TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
        mainView.startButton.addTarget(self, action: #selector(clickedStartButton), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(clickedCancelButton), for: .touchUpInside)
    }

    
    func startTimer(){
        
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                
                guard let self = self else {return}
                
                self.currentSeconds -= 1
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.mainView.timeLabel.text = String(format: "%02d:%02d:%02d", hour,minutes,seconds)
                self.mainView.progress.progress = Float(self.currentSeconds) / Float(self.duration)
                
                UIView.animate(withDuration: 0.3, delay: 0, animations: {
                    self.mainView.tomato.transform = CGAffineTransform(rotationAngle: .pi)
                    //뷰를 이동시키거나 스케일 조정, 회전 등 가능
                })
                UIView.animate(withDuration: 0.5,delay: 0.5, animations: {
                    self.mainView.tomato.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })
                
                
                if self.currentSeconds <= 0 {
                    self.stopTimer()
                    //iphondev.wiki
                    AudioServicesPlaySystemSound(1005)
                }
            })
            self.timer?.resume()
        }
        
    }
    
    
    func stopTimer(){
        
        if self.timerStatus == .pause{
            self.timer?.resume()
        }
        
        self.timerStatus = .end
        mainView.cancelButton.isEnabled = false
        mainView.startButton.isSelected = false

        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.timeLabel.alpha = 0
            self.mainView.progress.alpha = 0
            self.mainView.datePicker.alpha = 1
            self.mainView.tomato.transform = .identity
        })
        
        self.timer?.cancel()
        self.timer = nil //타이머를 메모리에서 해제시켜야하기 때문
        
    }
    // Animation 처리
//    func setTimerInfoViewVisble(isHidden:Bool) {
//
//        mainView.timeLabel.isHidden = isHidden
//        mainView.progress.isHidden = isHidden
//
//    }
    
    func configureToggleButton(){
        mainView.startButton.setTitle("시작", for: .normal)
        mainView.startButton.setTitle("일시정지", for: .selected)
    }
    
    @objc func clickedStartButton(){
        
        self.duration = Int(mainView.datePicker.countDownDuration)
        
        switch self.timerStatus {
            
        case .end:
            self.timerStatus = .start
           
            UIView.animate(withDuration: 0.3, animations: {
                self.mainView.timeLabel.alpha = 1
                self.mainView.progress.alpha = 1
                self.mainView.datePicker.alpha = 0
            })
            
            mainView.startButton.isSelected = true
            mainView.cancelButton.isEnabled = true
            self.currentSeconds = self.duration
            self.startTimer()
            
        case .start:
            self.timerStatus = .pause
            mainView.startButton.isSelected = false
            self.timer?.suspend()
    
        
        case .pause:
            self.timerStatus = .start
            mainView.startButton.isSelected = true
            self.timer?.resume()
        }
    }
    
    
    @objc func clickedCancelButton(){
        switch self .timerStatus {
            
        case .start, .pause:
            self.stopTimer()
            
        case .end:
            self.timerStatus = .start
            mainView.cancelButton.isEnabled = true
        }
        
    }
    
}

