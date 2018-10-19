//
//  ViewController.swift
//  SpokeStackExample
//
//  Created by Cory D. Wiles on 10/8/18.
//  Copyright © 2018 Pylon AI, Inc. All rights reserved.
//

import UIKit
import SpokeStack

struct GoogleConfiguration: GoogleRecognizerConfiguration {
    
    var host: String {
        return "speech.googleapis.com"
    }
    
    var apiKey: String {
        return "AIzaSyAX01kY6iygg04-dexAr-cR9ZdYSMemWL0"
    }
    
    var enableWordTimeOffsets: Bool {
        return true
    }
    
    var maxAlternatives: Int32 {
        return 30
    }
    
    var singleUtterance: Bool {
        return false
    }
    
    var interimResults: Bool {
        return true
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var startRecordingButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var resultsLabel: UILabel!

    lazy private var pipeline: SpeechPipeline = {
        
        let configuration: GoogleConfiguration = GoogleConfiguration()
        return try! SpeechPipeline(.google,
                                   configuration: configuration,
                                   delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startRecordingAction(_ sender: Any) {
        self.pipeline.start()
    }

    @IBAction func stopRecordingAction(_ sender: Any) {
        self.pipeline.stop()
    }
}

extension ViewController: SpeechRecognizer {
    
    func didStart() {
        self.startRecordingButton.isEnabled.toggle()
    }
    
    func didFinish() {
        self.startRecordingButton.isEnabled.toggle()
    }
    
    func didRecognize(_ result: SPSpeechContext) {
        
        let resultText: String = "\(result.transcript) confidence \(result.confidence)"
        self.resultsLabel.text = resultText
    }
}

