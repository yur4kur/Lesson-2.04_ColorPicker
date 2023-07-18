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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: Public properties
    var delegate: ISettingsViewControllerDelegate!
    var returnedColor: UIColor!
    
    // MARK: Private properties
    private var chosenColor: UIColor {
         UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalColorView.layer.cornerRadius = finalColorView.bounds.height * 0.15
        setFinalColorView(with: returnedColor)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setSlidersValues(from: returnedColor)
        setupSlider(redSlider, minimumTrackColor: .red)
        setupSlider(greenSlider, minimumTrackColor: .green)
        setupSlider(blueSlider, minimumTrackColor: .blue)
        
        setLabelAndTextfieldText(of: redValueLabel, and: redTextField, from: redSlider)
        setLabelAndTextfieldText(of: greenValueLabel, and: greenTextField, from: greenSlider)
        setLabelAndTextfieldText(of: blueValueLabel, and: blueTextField, from: blueSlider)
        
        let toolbar = createToolbar()
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(false)
    }
    
    // MARK: IBActions
    @IBAction func moveSlider(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setLabelAndTextfieldText(of: redValueLabel, and: redTextField, from: sender)
        case greenSlider:
            setLabelAndTextfieldText(of: greenValueLabel, and: greenTextField, from: sender)
        default:
            setLabelAndTextfieldText(of: blueValueLabel, and: blueTextField, from: sender)
        }
        setFinalColorView(with: chosenColor)
    }
    
    @IBAction func doneButtonDidTap() {
        delegate.setNewColor(with: chosenColor)
        dismiss(animated: true)
    }
    
    // MARK: Private methods
    private func setFinalColorView(with color: UIColor) {
        finalColorView.backgroundColor = color
    }
    
    private func setLabelAndTextfieldText(of label: UILabel, and textField: UITextField, from slider: UISlider) {
        label.text = String(format: "%.2f", slider.value)
        textField.text = String(format: "%.2f", slider.value)
    }
    
    private func setupSlider(_ slider: UISlider, minimumTrackColor color: UIColor) {
        slider.minimumTrackTintColor = color
        slider.maximumTrackTintColor = .placeholderText
    }
    
    private func setSlidersValues(from color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil)
        let toolbarDoneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneDidTap))
        toolbar.items = [flexibleSpace, toolbarDoneButton]
        toolbar.sizeToFit()
        return toolbar
    }
    
    @objc private func doneDidTap() {
        view.endEditing(false)
    }
}

// MARK: Extensions
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text?.removeAll()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            return showAlert(title: "Ooops!", message: "Value is missing!")
        }
        guard let value = Float(text), (value >= 0 && value <= 1) else {
            return showAlert(title: "Wrong value", message: "Value must be decimal!", textField: textField)
        }
            switch textField {
            case redTextField:
                redValueLabel.text = textField.text
                redSlider.setValue(value, animated: true)
            case greenTextField:
                greenValueLabel.text = textField.text
                greenSlider.setValue(value, animated: true)
            default:
                blueValueLabel.text = blueTextField.text
                blueSlider.setValue(value, animated: true)
            }
            setFinalColorView(with: chosenColor)
    }
}
