//
//  ViewController.swift
//  Lesson 2.04_ColorPicker
//
//  Created by Юрий Куринной on 14.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var finalColorView: UIView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connect(slider: redSlider, toLabel: redValueLabel, trackColor: .red)
        connect(slider: greenSlider, toLabel: greenValueLabel, trackColor: .green)
        connect(slider: blueSlider, toLabel: blueValueLabel, trackColor: .blue)
    }
    
    // MARK: IBActions
    @IBAction func moveSlider(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redValueLabel.text = String(format: "%.2f", sender.value)
        case 1:
            greenValueLabel.text = String(format: "%.2f", sender.value)
        case 2:
            blueValueLabel.text = String(format: "%.2f", sender.value)
        default:
            print("Something gone wrong")
        }
    }
    
    // MARK: Private methods
    private func connect(slider: UISlider, toLabel label: UILabel, trackColor color: UIColor) {
        label.text = slider.value.formatted()
        slider.minimumTrackTintColor = color
    }
    

}

