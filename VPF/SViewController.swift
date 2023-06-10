//
//  SViewController.swift
//  VPF
//
//  Created by PHN Tech 2 on 29/05/23.
//

import UIKit
import AVKit

class SViewController: UIViewController {
    @IBOutlet weak var videoContainer: UIView!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var isPlaying = false

    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var progressBar: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a video URL
        guard let videoURL = URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else {
            print("Invalid video URL")
            return
        }

        
// Create an AVPlayerItem
        let playerItem = AVPlayerItem(url: videoURL)

        // Create an AVPlayer with the AVPlayerItem
        player = AVPlayer(playerItem: playerItem)

        // Create an AVPlayerLayer to display the video
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoContainer.bounds
        videoContainer.layer.addSublayer(playerLayer!)

        // Add periodic time observer to update playback progress
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.updatePlaybackProgress(currentTime: time)
        }

        // Start playing the video
        player?.play()
        isPlaying = true
        updatePlayPauseButtonImage()
    }

    override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    playerLayer?.frame = videoContainer.bounds
}

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
    if isPlaying {
    player?.pause()
} else {
    player?.play()
}
    isPlaying.toggle()
    updatePlayPauseButtonImage()
}

    @IBAction func progressBarValueChanged(_ sender: UISlider) {
    let progress = sender.value
    let duration = player?.currentItem?.duration.seconds ?? 0
        let time = CMTime(seconds: Double(progress) * duration, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    player?.seek(to: time)
}

    func updatePlaybackProgress(currentTime: CMTime) {
    let duration = player?.currentItem?.duration.seconds ?? 0
    let currentTimeSeconds = currentTime.seconds

    progressBar.value = Float(currentTimeSeconds / duration)

    let currentMinutes = Int(currentTimeSeconds / 60)
        let currentSeconds = Int(currentTimeSeconds.truncatingRemainder(dividingBy: 60))
        currentTimeLabel.text = String(format: "%02d:%02d", currentMinutes, currentSeconds)

    let totalMinutes = Int(duration / 60)
        let totalSeconds = Int(duration.truncatingRemainder(dividingBy: 60))
        totalTimeLabel.text = String(format: "%02d:%02d", totalMinutes, totalSeconds)
}

    func updatePlayPauseButtonImage() {
        let buttonImage = isPlaying ? UIImage(systemName: "pause.fill") : UIImage(systemName: "play.fill")
    playPauseButton.setImage(buttonImage, for: .normal)
}

    // Add additional methods and logic for volume controls, fullscreen support, and error handling

}
