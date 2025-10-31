//
//  ViewController.swift
//  Soniva
//
//  Created by Zhumatay Sayana on 30.10.2025.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    var player: AVAudioPlayer?
    var currentIndex = 0

    let songs = [
        ("Когда твоя девушка больна", "Виктор Цой", "kino1_music", "kino1"),
        ("Песня без слов", "Виктор Цой", "kino2_music", "kino2"),
        ("Daylight", "Joji", "joji_music", "joji"),
        ("Ambitionz az a ridah", "2Pac", "2pac_music", "2pac"),
        ("Bohemian rhapsody", "Queen", "queen_music", "queen"),
        ("Accidentally in Love", "Counting Crows", "shrek_music", "shrek")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDesign()
        preparePlayer(for: songs[currentIndex].2)
        updatePlayButtonTitle()
    }
//round buttons
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [previousButton, playButton, nextButton].forEach { b in
            b?.layer.cornerRadius = (b?.frame.height ?? 0) / 2
            b?.clipsToBounds = true
        }
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        if let p = player, p.isPlaying {
            p.pause()
        } else {
            player?.play()
        }
        updatePlayButtonTitle()
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentIndex += 1
        if currentIndex >= songs.count { currentIndex = 0 }
        updateUI()
        preparePlayer(for: songs[currentIndex].2)
        player?.play()
        updatePlayButtonTitle()
    }

    @IBAction func previousButtonTapped(_ sender: UIButton) {
        currentIndex -= 1
        if currentIndex < 0 { currentIndex = songs.count - 1 }
        updateUI()
        preparePlayer(for: songs[currentIndex].2)
        player?.play()
        updatePlayButtonTitle()
    }

    func updateUI() {
        let songDescription = songs[currentIndex]
        titleLabel.text = songDescription.0
        artistLabel.text = songDescription.1
        backgroundImage.image = UIImage(named: songDescription.3)
    }
//round photo
    func setupDesign() {
        backgroundImage.layer.cornerRadius = 40
        backgroundImage.clipsToBounds = true
    }
//change button play to pause
    func updatePlayButtonTitle() {
        if player?.isPlaying == true {
            playButton.setTitle("Pause", for: .normal)
        } else {
            playButton.setTitle("Play", for: .normal)
        }
    }

    func preparePlayer(for name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            return
        }
        if let data = NSDataAsset(name: name)?.data {
            player = try? AVAudioPlayer(data: data)
            player?.prepareToPlay()
            return
        }
        print("YOOOOPS no such music in your directory: \(name)")
        player = nil
    }
}
