//
//  EggTimerView.swift
//  EggTimer
//
//  Created by Karine Mendonça on 2023-04-02.
//

import Foundation
import UIKit
import AVFoundation

class EggTimerViewController: UIViewController {
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    let eggTime: [String : Int ] = ["Soft" : 30,
                   "Medium" : 4,
                   "Hard" : 7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 203/255.0, green: 242/255.0, blue: 252/255.0, alpha: 1)
        
        setupView()
    }
    
    // MARK: - UI properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelView: UIView = {
        let labelView = UIView()
        labelView.backgroundColor = .clear
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "How do you like your eggs ?"
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var eggsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.tintColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var softEggsView: UIView = {
        let softEggsView = UIView()
        softEggsView.backgroundColor = .clear
        softEggsView.translatesAutoresizingMaskIntoConstraints = false
        return softEggsView
    }()
    
    private lazy var mediumEggsView: UIView = {
        let mediumEggsView = UIView()
        mediumEggsView.backgroundColor = .clear
        mediumEggsView.translatesAutoresizingMaskIntoConstraints = false
        return mediumEggsView
    }()
    
    private lazy var hardEggsView: UIView = {
        let hardEggsView = UIView()
        hardEggsView.backgroundColor = .clear
        hardEggsView.translatesAutoresizingMaskIntoConstraints = false
        return hardEggsView
    }()
    
    private lazy var softImageView: UIImageView = {
        let softImageView = UIImageView()
        softImageView.contentMode = .scaleAspectFit
        softImageView.image = UIImage(named: "soft_egg")
        softImageView.translatesAutoresizingMaskIntoConstraints = false
        return softImageView
    }()
    
    private lazy var mediumImageView: UIImageView = {
        let mediumImageView = UIImageView()
        mediumImageView.contentMode = .scaleAspectFit
        mediumImageView.image = UIImage(named: "medium_egg")
        mediumImageView.translatesAutoresizingMaskIntoConstraints = false
        return mediumImageView
    }()
    
    private lazy var hardImageView: UIImageView = {
        let hardImageView = UIImageView()
        hardImageView.contentMode = .scaleAspectFit
        hardImageView.image = UIImage(named: "hard_egg")
        hardImageView.translatesAutoresizingMaskIntoConstraints = false
        return hardImageView
    }()
    
    private lazy var softButton: UIButton = {
        let softButton = UIButton()
        softButton.backgroundColor = .clear
        softButton.titleLabel?.textColor = .white
        softButton.setTitle("Soft", for: .normal)
        softButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        softButton.addTarget(self, action: #selector(self.eggButtonClicked(sender:)), for: .touchUpInside)
        softButton.translatesAutoresizingMaskIntoConstraints = false
        return softButton
    }()
    
    private lazy var mediumButton: UIButton = {
        let mediumButton = UIButton()
        mediumButton.backgroundColor = .clear
        mediumButton.titleLabel?.textColor = .white
        mediumButton.setTitle("Medium", for: .normal)
        mediumButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        mediumButton.addTarget(self, action: #selector(self.eggButtonClicked(sender:)), for: .touchUpInside)
        mediumButton.translatesAutoresizingMaskIntoConstraints = false
        return mediumButton
    }()
    
    private lazy var hardButton: UIButton = {
        let hardButton = UIButton()
        hardButton.backgroundColor = .clear
        hardButton.titleLabel?.textColor = .white
        hardButton.setTitle("Hard", for: .normal)
        hardButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        hardButton.translatesAutoresizingMaskIntoConstraints = false
        hardButton.addTarget(self, action: #selector(self.eggButtonClicked(sender:)), for: .touchUpInside)
        return hardButton
    }()
    
    private lazy var progressView: UIView = {
        let progressView = UIView()
        progressView.backgroundColor = .clear
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.progressViewStyle = .bar
        progressBar.progress = 0.0
        progressBar.progressTintColor = .yellow
        progressBar.trackTintColor = .darkGray
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    @objc private func eggButtonClicked(sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        self.progressBar.progress = 0.0
        self.secondsPassed = 0
        self.titleLabel.text = hardness
    
        if self.eggTime[hardness] != nil {
            self.totalTime = self.eggTime[hardness]!
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed <= self.totalTime {
                self.progressBar.progress = Float(self.secondsPassed)/Float(self.totalTime)
                self.secondsPassed += 1
            } else {
                self.timer.invalidate()
                self.titleLabel.text = "DONE!"
                self.playSound()
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

extension EggTimerViewController: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(labelView)
        stackView.addArrangedSubview(eggsStackView)
        stackView.addArrangedSubview(progressView)
        labelView.addSubview(titleLabel)
        eggsStackView.addArrangedSubview(softEggsView)
        eggsStackView.addArrangedSubview(mediumEggsView)
        eggsStackView.addArrangedSubview(hardEggsView)
        softEggsView.addSubview(softImageView)
        mediumEggsView.addSubview(mediumImageView)
        hardEggsView.addSubview(hardImageView)
        softEggsView.addSubview(softButton)
        mediumEggsView.addSubview(mediumButton)
        hardEggsView.addSubview(hardButton)
        progressView.addSubview(progressBar)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: labelView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor),
            
            softImageView.topAnchor.constraint(equalTo: softEggsView.topAnchor),
            softImageView.bottomAnchor.constraint(equalTo: softEggsView.bottomAnchor),
            softImageView.trailingAnchor.constraint(equalTo: softEggsView.trailingAnchor),
            softImageView.leadingAnchor.constraint(equalTo: softEggsView.leadingAnchor),
            
            softButton.topAnchor.constraint(equalTo: softEggsView.topAnchor),
            softButton.bottomAnchor.constraint(equalTo: softEggsView.bottomAnchor),
            softButton.trailingAnchor.constraint(equalTo: softEggsView.trailingAnchor),
            softButton.leadingAnchor.constraint(equalTo: softEggsView.leadingAnchor),

            mediumImageView.topAnchor.constraint(equalTo: mediumEggsView.topAnchor),
            mediumImageView.bottomAnchor.constraint(equalTo: mediumEggsView.bottomAnchor),
            mediumImageView.trailingAnchor.constraint(equalTo: mediumEggsView.trailingAnchor),
            mediumImageView.leadingAnchor.constraint(equalTo: mediumEggsView.leadingAnchor),
            
            mediumButton.topAnchor.constraint(equalTo: mediumEggsView.topAnchor),
            mediumButton.bottomAnchor.constraint(equalTo: mediumEggsView.bottomAnchor),
            mediumButton.trailingAnchor.constraint(equalTo: mediumEggsView.trailingAnchor),
            mediumButton.leadingAnchor.constraint(equalTo: mediumEggsView.leadingAnchor),
            
            hardImageView.topAnchor.constraint(equalTo: hardEggsView.topAnchor),
            hardImageView.bottomAnchor.constraint(equalTo: hardEggsView.bottomAnchor),
            hardImageView.trailingAnchor.constraint(equalTo: hardEggsView.trailingAnchor),
            hardImageView.leadingAnchor.constraint(equalTo: hardEggsView.leadingAnchor),
            
            hardButton.topAnchor.constraint(equalTo: hardEggsView.topAnchor),
            hardButton.bottomAnchor.constraint(equalTo: hardEggsView.bottomAnchor),
            hardButton.trailingAnchor.constraint(equalTo: hardEggsView.trailingAnchor),
            hardButton.leadingAnchor.constraint(equalTo: hardEggsView.leadingAnchor),
            
            progressView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            progressBar.trailingAnchor.constraint(equalTo: progressView.trailingAnchor),
            progressBar.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            progressBar.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: 0)

        ])
    }
}
