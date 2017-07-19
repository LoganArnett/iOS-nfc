//
//  ViewController.swift
//  NFCReader
//
//  Created by Logan Arnett on 7/13/17.
//  Copyright © 2017 LiftTheWeb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var helper: NFCHelper?
    var payloadLabel: UILabel!
    var payloadText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add a detect button
        let button = UIButton(type: .system)
        button.setTitle("Read NFC", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 28.0)
        button.isEnabled = true
        button.addTarget(self, action: #selector(didTapReadNFC), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 200, width: self.view.bounds.width - 120, height: 80)
        self.view.addSubview(button)
        // Add a label to display the payload in
        payloadLabel = UILabel(frame: button.frame.offsetBy(dx: 0, dy: 220))
        payloadLabel.text = "Press Read to see payload data."
        payloadLabel.numberOfLines = 100
        self.view.addSubview(payloadLabel)
    }
    // Called by NFCHelper when a tag is read, or fails to read
    func onNFCResult(success: Bool, message: String) {
        if success {
            payloadText = "\(payloadText)\n\(message)"
        }
        else {
            payloadText = "\(payloadText)\n\(message)"
        }
        // Update UI on main thread
        DispatchQueue.main.async {
            self.payloadLabel.text = self.payloadText
        }
        
    }
    // Called when user taps Read NFC Button
    @objc func didTapReadNFC() {
        if helper == nil {
            helper = NFCHelper()
            helper?.onNFCResult = self.onNFCResult(success:message:)
        }
        payloadText = ""
        helper?.restartSession()
    }
}

