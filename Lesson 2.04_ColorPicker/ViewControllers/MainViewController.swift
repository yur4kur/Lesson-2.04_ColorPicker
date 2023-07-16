//
//  MainViewController.swift
//  Lesson 2.04_ColorPicker
//
//  Created by Юрий Куринной on 15.07.2023.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: Override maethods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
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
