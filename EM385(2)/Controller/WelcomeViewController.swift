//
//  ViewController.swift
//  EM385(2)
//
//  Created by Joy on 7/17/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "goToTabBar", sender: self)
    }


}

