//
//  SettingsViewController.swift
//  EM385(2)
//
//  Created by Joy on 3/15/25.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let savedTheme = UserDefaults.standard.string(forKey: "theme") ?? "light"
        
        if savedTheme == "dark" {
            themeSwitch.isOn = true
            view.window?.overrideUserInterfaceStyle = .dark
        } else {
            themeSwitch.isOn = false
            view.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    @IBAction func WaiverButtonPressed() {
    }
    
    @IBOutlet weak var themeSwitch: UISwitch! // Connect this to your UISwitch in Storyboard


    @IBAction func switchTheme(_ sender: UISwitch) {
        guard let windowScene = view.window?.windowScene else { return }
        
        if sender.isOn {
            windowScene.windows.forEach { $0.overrideUserInterfaceStyle = .dark }
            UserDefaults.standard.set("dark", forKey: "theme")
        } else {
            windowScene.windows.forEach { $0.overrideUserInterfaceStyle = .light }
            UserDefaults.standard.set("light", forKey: "theme")
        }
    }

    @IBAction func darkModePressed(_sender: UIButton) {
//        guard let windowScene = view.window?.windowScene else { return }
//           
//           let currentStyle = windowScene.windows.first?.overrideUserInterfaceStyle
//           
//           if currentStyle == .light {
//               windowScene.windows.forEach { $0.overrideUserInterfaceStyle = .dark }
//               UserDefaults.standard.set("dark", forKey: "theme")
//               darkModePressed(_sender: <#T##UIButton#>).label = "Light Mode"
//           } else {
//               windowScene.windows.forEach { $0.overrideUserInterfaceStyle = .light }
//               UserDefaults.standard.set("light", forKey: "theme")
//           }
    }
}
