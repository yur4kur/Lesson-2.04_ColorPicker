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
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        finalColorView.layer.cornerRadius = finalColorView.bounds.height * 0.15
        setColor()
        
        setLabelText(of: redValueLabel, from: redSlider)
        setLabelText(of: greenValueLabel, from: greenSlider)
        setLabelText(of: blueValueLabel, from: blueSlider)
        
        setupSlider(redSlider, minimumTrackColor: .red)
        setupSlider(greenSlider, minimumTrackColor: .green)
        setupSlider(blueSlider, minimumTrackColor: .blue)
    }
    
    // MARK: IBActions
    @IBAction func moveSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setLabelText(of: redValueLabel, from: sender)
        case greenSlider:
            setLabelText(of: greenValueLabel, from: sender)
        default:
            setLabelText(of: blueValueLabel, from: sender)
        }
        setColor()
    }
    
    // MARK: Private methods
    private func setLabelText(of label: UILabel, from slider: UISlider) {
        label.text = String(format: "%.2f", slider.value)
    }
    
    private func setupSlider(_ slider: UISlider, minimumTrackColor color: UIColor) {
        slider.minimumTrackTintColor = color
        slider.maximumTrackTintColor = .placeholderText
    }
    
    private func setColor() {
        finalColorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

