//
//  ViewController.swift
//  Lesson 2.04_ColorPicker
//
//  Created by Юрий Куринной on 14.06.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var finalColorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: Public properties
    var delegate: SettingsViewControllerDelegate!
    var returnedColor: UIColor!
    
    // MARK: Private properties
    private var chosenColor: UIColor {
        get { UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        }
    }
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalColorView.layer.cornerRadius = finalColorView.bounds.height * 0.15
        finalColorView.backgroundColor = returnedColor
        setSlidersValues(color: returnedColor)
        
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
        finalColorView.backgroundColor = chosenColor
    }
    
    @IBAction func doneButtonDidTap() {
        delegate.setNewColor(with: chosenColor)
        dismiss(animated: true)
    }
    
    // MARK: Private methods
    private func setLabelText(of label: UILabel, from slider: UISlider) {
        label.text = String(format: "%.2f", slider.value)
    }
    
    private func setupSlider(_ slider: UISlider, minimumTrackColor color: UIColor) {
        slider.minimumTrackTintColor = color
        slider.maximumTrackTintColor = .placeholderText
    }
    
    private func setSlidersValues(color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
}

