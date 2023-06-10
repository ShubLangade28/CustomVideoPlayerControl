//
//  ViewController.swift
//  VPF
//
//  Created by Mac on 26/05/23.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    // Video Player and Video view setup
    let videoContainerView = UIView()
    let stackView = UIStackView()
    let videoSeekBarStack = UIStackView()
    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    let avpController = AVPlayerViewController()
    let seekDuration : Float64 = 5
    
    
    
    //Constrints
    var videoContainerViewConstrints : [NSLayoutConstraint] = []
    var videoContainerViewLConstrints : [NSLayoutConstraint] = []
    
    private var muteButtonConstaints: [NSLayoutConstraint] = []
    private var muteButtonLConstints : [NSLayoutConstraint] = []
    private var stackViewConstrints : [NSLayoutConstraint] = []
    private var stackViewLConstrints : [NSLayoutConstraint] = []
    private var rotationButtonConstraints: [NSLayoutConstraint] = []
    private var rotationButtonLConstraints: [NSLayoutConstraint] = []
    
    private var currentTimeLabelConstraints: [NSLayoutConstraint] = []
    private var currentTimeLabelLConstraints: [NSLayoutConstraint] = []
    
    private var totalTimeLabelConstraints: [NSLayoutConstraint] = []
    private var totalTimeLabelLConstraints: [NSLayoutConstraint] = []
    
    private var progressBarConstraints: [NSLayoutConstraint] = []
    private var progressBarLConstraints: [NSLayoutConstraint] = []
    
    
    //Buttons
    let muteButton = UIButton()
    let pauseplayButton = UIButton()
    let seekBackwordButton = UIButton()
    let seekForwardButton = UIButton()
    let videoPlayerRotationButton = UIButton()
    let currentTimeLabel = UILabel()
    let totalTimeLabel = UILabel()
    let progressBar = UISlider()
    
    
    //Flags
    var videoVolumeFlag = true
    var videoPlaypauseFlag = true
    var islandscape = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Video view constrints
        let configuration = UIImage.SymbolConfiguration(pointSize: 12)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        progressBar.setThumbImage(image, for: .normal)
        progressBar.tintColor = .white
        videoContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoContainerView)
        
        // potrait
        videoContainerViewConstrints = [
            videoContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.05),
            videoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoContainerView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(videoContainerViewConstrints)
        videoContainerView.backgroundColor = .black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideShowControls))
        videoContainerView.addGestureRecognizer(tap)
        
        
        // Video Player
        let url = URL(string:"https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        player = AVPlayer(url: url!)
        avpController.player = player
        avpController.view.frame.size.height = videoContainerView.frame.size.height
        avpController.view.frame.size.width = videoContainerView.frame.size.width
        self.videoContainerView.addSubview(avpController.view)
        avpController.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avpController.allowsPictureInPicturePlayback = true
        avpController.showsPlaybackControls = false
        player.play()
        
        
        // Mute Button
        videoContainerView.addSubview(muteButton)
        muteButton.translatesAutoresizingMaskIntoConstraints = false
        muteButton.setImage(UIImage(systemName: "speaker.fill"), for: .normal)
        muteButton.tintColor = .white
        muteButton.addTarget(self, action: #selector(muteVideo), for: .touchUpInside)
        
        muteButtonConstaints = [
            muteButton.topAnchor.constraint(equalTo: videoContainerView.topAnchor, constant: 10),
            muteButton.leftAnchor.constraint(equalTo: videoContainerView.leftAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(muteButtonConstaints)
        
        //Middle Stack View
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewConstrints = [
            stackView.centerXAnchor.constraint(equalTo: videoContainerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: videoContainerView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstrints)
        
        stackView.addArrangedSubview(seekBackwordButton)
        stackView.addArrangedSubview(pauseplayButton)
        stackView.addArrangedSubview(seekForwardButton)
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.spacing = 30
        
        //PausePlay Button
        
        pauseplayButton.tintColor = .white
        pauseplayButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        pauseplayButton.addTarget(self, action: #selector(pausePlay), for: .touchUpInside)
        
        //Seek Backward Button
        
        seekBackwordButton.tintColor = .white
        seekBackwordButton.setImage(UIImage(systemName: "gobackward.10"), for: .normal)
        seekBackwordButton.addTarget(self, action: #selector(seekBackword), for: .touchUpInside)
        
        //Seek Forward Button
        seekForwardButton.tintColor = .white
        seekForwardButton.setImage(UIImage(systemName: "goforward.10"), for: .normal)
        seekForwardButton.addTarget(self, action: #selector(seekForward), for: .touchUpInside)
        
        // Video Player Potrait Landscap Button
        view.addSubview(videoPlayerRotationButton)
        videoPlayerRotationButton.translatesAutoresizingMaskIntoConstraints = false
        videoPlayerRotationButton.setImage(UIImage(systemName: "square.fill"), for: .normal)
        videoPlayerRotationButton.tintColor = .white
        videoPlayerRotationButton.addTarget(self, action: #selector(self.videoPlayerRotate), for: .touchUpInside)
        
        rotationButtonConstraints = [
            videoPlayerRotationButton.topAnchor.constraint(equalTo: videoContainerView.topAnchor, constant: 10),
            videoPlayerRotationButton.rightAnchor.constraint(equalTo: videoContainerView.rightAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(rotationButtonConstraints)
        
        //Progress Bar Stack
        view.addSubview(currentTimeLabel)
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTimeLabelConstraints = [
            currentTimeLabel.leftAnchor.constraint(equalTo: videoContainerView.leftAnchor, constant: 10),
            currentTimeLabel.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor, constant: -10),
            currentTimeLabel.widthAnchor.constraint(equalToConstant: 47)
        ]
        
        NSLayoutConstraint.activate(currentTimeLabelConstraints)
        
        view.addSubview(totalTimeLabel)
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalTimeLabelConstraints = [
            totalTimeLabel.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor, constant: -10),
            totalTimeLabel.rightAnchor.constraint(equalTo: videoContainerView.rightAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(totalTimeLabelConstraints)
        
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        progressBarConstraints = [
            progressBar.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 5),
            progressBar.bottomAnchor.constraint(equalTo: videoContainerView.bottomAnchor, constant: -13),
            progressBar.rightAnchor.constraint(equalTo: totalTimeLabel.leftAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(progressBarConstraints)
        
        currentTimeLabel.text = "00:00"
        totalTimeLabel.text = "09:00"
        currentTimeLabel.textColor = .white
        totalTimeLabel.textColor = .white
        
        //Progress bar action
        progressBar.addTarget(self, action: #selector(progressBarValueChanged), for: .touchUpInside)
        
        // Add periodic time observer to update playback progress
        let interval = CMTime(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { progressTime in
            if self.progressBar.isTracking == true{
                self.player.pause()
            }else{
                self.updatePlaybackProgress(currentTime: progressTime)
                if self.videoPlaypauseFlag == true{
                    self.player.play()
                }else{
                    self.player.pause()
                }
                
            }
        }
        
        
        
        muteButton.isHidden = true
        pauseplayButton.isHidden = true
        seekBackwordButton.isHidden = true
        seekForwardButton.isHidden = true
        videoPlayerRotationButton.isHidden = true
        currentTimeLabel.isHidden = true
        totalTimeLabel.isHidden = true
        progressBar.isHidden = true
        
    }
    
    // Device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.handleRotation()
        }, completion: nil)
    }
    
        // Function of device rotation
    func handleRotation() {
        let orientation = UIApplication.shared.statusBarOrientation
        
        switch orientation {
        case .portrait, .portraitUpsideDown:
            playerLayer.frame = videoContainerView.bounds
            NSLayoutConstraint.deactivate(videoContainerViewLConstrints)
            NSLayoutConstraint.activate(videoContainerViewConstrints)
        case .landscapeLeft, .landscapeRight:
            playerLayer.frame = view.bounds
            NSLayoutConstraint.deactivate(videoContainerViewConstrints)
            videoContainerViewLConstrints = [
                videoContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                videoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                videoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                videoContainerView.heightAnchor.constraint(equalToConstant: playerLayer.frame.height)
            ]
            NSLayoutConstraint.activate(videoContainerViewLConstrints)
        default:
            break
        }
    }

}

extension ViewController{
    //PausePlay Function
    
    @objc func muteVideo(){
        if videoVolumeFlag == true{
            player.isMuted = true
            videoVolumeFlag = false
            muteButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        }else{
            player.isMuted = false
            videoVolumeFlag = true
            muteButton.setImage(UIImage(systemName: "speaker.fill"), for: .normal)
        }
    }
    
    //PausePlay Function
    
    @objc func pausePlay(){
        if videoPlaypauseFlag == true{
            player.pause()
            videoPlaypauseFlag = false
            pauseplayButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }else{
            player.play()
            videoPlaypauseFlag = true
            pauseplayButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        }
    }
    
    //Seek Backword function
    @objc func seekBackword(){
        
        // Get the current time of the video
        let currentTime = CMTimeGetSeconds(player.currentTime())

        // Calculate the target time to seek backward by 10 seconds
        let targetTime = currentTime - 10

        // Make sure the target time is not negative
        let finalTime = max(targetTime, 0)

        // Create a CMTime instance with the final time
        let time = CMTimeMakeWithSeconds(finalTime, preferredTimescale: Int32(NSEC_PER_SEC))

        // Seek the video player to the final time
        player.seek(to: time)
    }
    
    //Seek Forward Function
    @objc func seekForward(){
        // Get the current time of the video
        let currentTime = CMTimeGetSeconds(player.currentTime())

        // Calculate the target time to seek forward by 10 seconds
        let targetTime = currentTime + 10

        // Create a CMTime instance with the target time
        let time = CMTimeMakeWithSeconds(targetTime, preferredTimescale: Int32(NSEC_PER_SEC))

        // Seek the video player to the target time
        player.seek(to: time)
    }
    
    // Video Player Rotate Function 
    @objc func videoPlayerRotate(){
        if islandscape == false{
            setDeviceOrientation(orientation: .landscape)
            islandscape = true
        }else{
            setDeviceOrientation(orientation: .portrait)
            islandscape = false
        }
    }
    
    @objc func progressBarValueChanged(sender: UISlider){
        let interval = CMTime(value: 1, timescale: 2)
        let progress = sender.value
        let duration = player.currentItem?.duration.seconds ?? 0
            let time = CMTime(seconds: Double(progress) * duration, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            self.player.seek(to: time)
        
    }
    
    @objc func hideShowControls(){
        muteButton.isHidden = false
        pauseplayButton.isHidden = false
        seekBackwordButton.isHidden = false
        seekForwardButton.isHidden = false
        videoPlayerRotationButton.isHidden = false
        currentTimeLabel.isHidden = false
        totalTimeLabel.isHidden = false
        progressBar.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
            self.muteButton.isHidden = true
            self.pauseplayButton.isHidden = true
            self.seekBackwordButton.isHidden = true
            self.seekForwardButton.isHidden = true
            self.videoPlayerRotationButton.isHidden = true
            self.currentTimeLabel.isHidden = true
            self.totalTimeLabel.isHidden = true
            self.progressBar.isHidden = true
        }
    }

    func updatePlaybackProgress(currentTime: CMTime) {
    let duration = player.currentItem?.duration.seconds ?? 0
    let currentTimeSeconds = currentTime.seconds
    self.progressBar.value = Float(currentTimeSeconds / duration)
        
    let currentMinutes = Int(currentTimeSeconds / 60)
        let currentSeconds = Int(currentTimeSeconds.truncatingRemainder(dividingBy: 60))
        currentTimeLabel.text = String(format: "%02d:%02d", currentMinutes, currentSeconds)

    let totalMinutes = Int(duration / 60)
        let totalSeconds = Int(duration.truncatingRemainder(dividingBy: 60))
        totalTimeLabel.text = String(format: "%02d:%02d", totalMinutes, totalSeconds)
        
}
    
}

extension UIInterfaceOrientationMask {
    var toUIInterfaceOrientation: UIInterfaceOrientation {
        switch self {
        case .portrait:
            return UIInterfaceOrientation.portrait
        case .portraitUpsideDown:
            return UIInterfaceOrientation.portraitUpsideDown
        case .landscapeRight:
            return UIInterfaceOrientation.landscapeRight
        case .landscapeLeft:
            return UIInterfaceOrientation.landscapeLeft
        default:
            return UIInterfaceOrientation.unknown
        }
    }
}

extension UIViewController {
    
    func setDeviceOrientation(orientation: UIInterfaceOrientationMask) {
        if #available(iOS 16.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: orientation))
        } else {
            UIDevice.current.setValue(orientation.toUIInterfaceOrientation.rawValue, forKey: "orientation")
        }
    }
}
