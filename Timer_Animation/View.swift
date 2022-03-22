//
//  mainView.swift
//  Timer_Animation
//
//  Created by mac on 2022/03/22.
//

import UIKit
import SnapKit



class View: UIView, BaseViewRepresentable {
    
    let tomato : UIImageView = {
        let i = UIImageView()
        
        i.image = UIImage(named: "tomato")
        
       return i
    }()
    let timeLabel = UILabel()
    let progress = UIProgressView()
    
    let btnStackView = UIStackView()
    let cancelButton = UIButton()
    let startButton = UIButton()
    
    let datePicker = UIDatePicker()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        self.backgroundColor = .white
        
        [tomato,timeLabel,progress,datePicker,btnStackView].forEach {
            addSubview($0)
        }
        
        [cancelButton,startButton].forEach{
            btnStackView.addArrangedSubview($0)
        }
        
        
        tomato.contentMode = .scaleAspectFit
        
        timeLabel.text = "00:00:00"
        timeLabel.isHidden = true
        timeLabel.font = .boldSystemFont(ofSize: 50)
        timeLabel.textAlignment = .center
        
        
        progress.progress = 1.0
        progress.isHidden = true
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .countDownTimer
        
        startButton.setTitle("시작", for: .normal)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.isEnabled = false
        startButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        startButton.setTitleColor(UIColor(red: 41/255, green: 157/255, blue: 255/255, alpha: 1), for: .normal)
        cancelButton.setTitleColor(UIColor(red: 255/255, green: 41/255, blue: 41/255, alpha: 1), for: .normal)
        

        btnStackView.axis = .horizontal
        btnStackView.distribution = .equalSpacing
        
    }
    
    func setupConstraints() {
        
        tomato.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(tomato.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
        
        progress.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(24)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(tomato.snp.bottom).offset(36)
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
        }
        
        btnStackView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(24)
            make.trailing.leading.equalTo(self.safeAreaLayoutGuide).inset(24)
          
        
        }
        
        
    }
    
  
    
    
    
    
    
    
}



