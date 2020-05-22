//
//  SplashScreenViewController.swift
//  GoT-Houses
//
//  Created by John Gallaugher on 4/1/20.
//  Copyright © 2020 John Gallaugher. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var throneImageView: UIImageView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(name: "GoT_theme")
        
        let yAtStart = throneImageView.frame.origin.y
        throneImageView.frame.origin.y = self.view.frame.height
        UIView.animate(withDuration: 1.0, delay: 1.0, animations: {self.throneImageView.frame.origin.y = yAtStart})
    }
    
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("😡 ERROR: \(error.localizedDescription). Could not initializer AVAudioPlayer object")
            }
        } else {
            print("😡 ERROR: Could not read data from file \(name)")
        }
    }

    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        if audioPlayer != nil {
            audioPlayer.stop()
        }
        performSegue(withIdentifier: "ShowTableView", sender: nil)
    }
}
