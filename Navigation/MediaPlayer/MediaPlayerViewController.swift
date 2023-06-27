//
//  MediaPlayerViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 23.06.2023.
//

import UIKit
import AVFoundation
import AVKit

class MediaPlayerViewController: UIViewController {
    
    // MARK: - Public properties
    
    var coordinator: CoordinatorProtocol?
    
    // MARK: - Private properties
    
   // private var mediaPlayerDelegate: MediaPlayerViewControllerDelegate
    
    private var audioPlayer: AVAudioPlayer!
    private var counter = 0
    //private let systemSounds: [String: SystemSoundID] = ["SMSReceived": 1003, "CalendarAlert": 1005, "MailReceived": 1000, "LowPower": 1006]
    private var someSongs: [String: Int] = ["Louis Armstrong": 0, "ChicagoIfYouMeNow": 1, "RichardMarxShouldKnowBetter": 2, "WhamChristmas" : 3, "TheMidnightVampires" : 4, "TheMidnightRiverOfDarkness" : 5]
    
    private lazy var soundNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Музыкальный трек"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play"), for: .normal)
        //button.tintColor = .black
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton() 
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "stop.circle"), for: .normal)
        //button.tintColor = .black
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubView()
        setupConstraints()
        setupAudioPlayer()
    }
    

    // MARK: - Public methods
    
    @objc private func playButtonAction(_ sender: Any) {
        print("fgf")
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            print("pause")
            playButton.setImage(UIImage(named: "play.rectangle"), for: .normal)
        } else {
            audioPlayer.play()
            print ("play")
            playButton.setImage(UIImage(named: "pause.rectangle"), for: .normal)
        }
       // playSystemSound()
    }
    
    @objc private func stopButtonAction(_ sender: Any) { // скорее всего ошибка!
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            print("stop")
        }
    }
    
    
    // MARK: - Private methods
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
//    private func playSystemSound() {
//        let currentSoundId = Array(someSongs.values)[counter]
//        let currentSoundName = Array(someSongs.keys)[counter]
//
//        AudioServicesPlaySomeSongs(currentSoundId)
//        soundNameLabel.text = currentSoundName
//
//        if counter == someSongs.count - 1 {
//            counter = 0
//        } else {
//            counter += 1
//        }
//    }
    
    private func setupAudioPlayer() {
        guard let musicUrl = Bundle.main.url(forResource: "Louis Armstrong", withExtension: "mp3") else { return }
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: musicUrl)
//                    let currentSoundId = Array(someSongs.values)[counter]
//                    let currentSoundName = Array(someSongs.keys)[counter]
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addSubView() {
        view.addSubview(soundNameLabel)
        view.addSubview(playButton)
        view.addSubview(stopButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            soundNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            soundNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 100),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            
            stopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
//            stopButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -20),
            stopButton.rightAnchor.constraint(equalTo: playButton.leftAnchor),
            stopButton.heightAnchor.constraint(equalToConstant: 100),
            stopButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}

