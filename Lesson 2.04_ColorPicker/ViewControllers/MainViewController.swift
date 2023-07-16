//
//  MainViewController.swift
//  Lesson 2.04_ColorPicker
//
//  Created by Юрий Куринной on 15.07.2023.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.returnedColor = self.view.backgroundColor
    }
}

// MARK: Extensions
extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(with color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: Protocols
protocol SettingsViewControllerDelegate {
    func setNewColor(with color: UIColor)
}