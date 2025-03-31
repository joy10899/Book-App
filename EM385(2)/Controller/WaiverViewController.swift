//
//  WaiverViewController.swift
//  EM385(2)
//
//  Created by Joy on 3/15/25.
//

import UIKit

class WaiverViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let savedTheme = UserDefaults.standard.string(forKey: "theme") ?? "light"
            overrideUserInterfaceStyle = (savedTheme == "dark") ? .dark : .light
        label.text = " Waiver: While every effort has been made to ensure the accuracy and validity of the information presented by this application(APP), Kugan & Associates, NAVFAC, USACE, Qnexis, site sponsors, advisors or third party providers may not held liable for any special, incidental, consequential, indirect or similar damages due to injury, illness, loss of data, loss of business profits, business interruption or any other reason. By using this application, you are assuming full responsibility for any and all consequences.\n\n While we intend to keep the information in this APP accurate and up-to-date, we make no representations or warranties of any kind, expressed or implied, about the completeness or accuracy of the information provided. Any reliance you place on such  information is strictly at your own risk. \n\n Through this APP, you will be able to link to other websites which are not under the control of this APP. We have no control over the nature, content and availability of those websites. The inclusion of any links does not necessarily imply a recommendation or endore the view expressed within them. \n\n Every effort is made to keep this APP fully operational. However, Kugan & Associates, NAVFAC, USACE and Qnexis take no  responsibility for, and will not be liable for, the APP being temporarily unavailable due to technical issues beyond our control."
        label.sizeToFit()
    }
  
}
