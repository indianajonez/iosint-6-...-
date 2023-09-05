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
    
    private let largeConfig = UIImage.SymbolConfiguration(scale: .large)
    
    private var player = AVPlayer()
    private var audioPlayer: AVAudioPlayer!
    private let path1 = Bundle.main.path(forResource: "Louis Armstrong", ofType: "mp3")
    private lazy var url1 = URL(fileURLWithPath: path1 ?? "")
    private let path2 = Bundle.main.path(forResource: "ChicagoIfYouMeNow", ofType: "mp3")
    private lazy var url2 = URL(fileURLWithPath: path2 ?? "")
    private let path3 = Bundle.main.path(forResource: "RichardMarxShouldKnowBetter", ofType: "mp3")
    private lazy var url3 = URL(fileURLWithPath: path3 ?? "")
    private let path4 = Bundle.main.path(forResource: "TheMidnightRiverOfDarkness", ofType: "mp3")
    private lazy var url4 = URL(fileURLWithPath: path4 ?? "")
    private lazy var item1 = AVPlayerItem(url: url1)
    private lazy var item2 = AVPlayerItem(url: url2)
    private lazy var item3 = AVPlayerItem(url: url3)
    private lazy var item4 = AVPlayerItem(url: url4)
    private lazy var playlist = [item1, item2, item3, item4]
    private var counter = 0
    private lazy var soundNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Музыкальный трек"
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var stopButton: UIButton = {
        let button = UIButton() 
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "stop.circle", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "forward.circle", withConfiguration: largeConfig), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(forwardButtonAction), for: .touchUpInside)
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
    
    @objc private func playButtonAction() {
        player.play()
//        if audioPlayer.isPlaying {
//            audioPlayer.pause()
//            playButton.setImage(UIImage(systemName: "play.rectangle"), for: .normal)
//        } else { 
//            audioPlayer.play()
//            playButton.setImage(UIImage(systemName: "pause.rectangle"), for: .normal)
//        }
    }
    
    @objc private func stopButtonAction() {
//        if audioPlayer.isPlaying {
//            audioPlayer.stop()
//            print("stop")
//        }
        player.pause()
        player.seek(to: .zero)
    }
    
    @objc private func forwardButtonAction() {
        guard let currentItem = player.currentItem else { return }
        guard let currentIndex = playlist.firstIndex(of: currentItem) else { return }
        let nextIndex = (currentIndex + 1) % playlist.count
        let nextItem = playlist[nextIndex]
        player.seek(to: .zero)
        player.replaceCurrentItem(with: nextItem)
        player.play()
    }
    
    
    // MARK: - Private methods
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupAudioPlayer() {
//        guard let musicUrl = Bundle.main.url(forResource: "Louis Armstrong", withExtension: "mp3") else { return }
//        do {
//            try audioPlayer = AVAudioPlayer(contentsOf: musicUrl)
////                    let currentSoundId = Array(someSongs.values)[counter]
////                    let currentSoundName = Array(someSongs.keys)[counter]
//        } catch {
//            print(error.localizedDescription)
//        }
        player.replaceCurrentItem(with: playlist.randomElement())
    }
    
    private func addSubView() {
        view.addSubview(soundNameLabel)
        view.addSubview(playButton)
        view.addSubview(stopButton)
        view.addSubview(forwardButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            soundNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            soundNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            playButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70),
//            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            stopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stopButton.trailingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 100),
            
            forwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            forwardButton.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 50),
            
        ])
    }
    
}

