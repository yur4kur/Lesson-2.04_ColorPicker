//
//  MainViewController.swift
//  Lesson 2.04_ColorPicker
//
//  Created by Юрий Куринной on 15.07.2023.
//

import UIKit

protocol ISettingsViewControllerDelegate {
    func setNewColor(with color: UIColor)
}

final class MainViewController: UIViewController {

    // MARK: Override methods 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.returnedColor = self.view.backgroundColor
    }
}

// MARK: Extensions
extension MainViewController: ISettingsViewControllerDelegate {
    func setNewColor(with color: UIColor) {
        view.backgroundColor = color
    }
}


