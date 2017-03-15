

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nametextField.underlined()
        emailField.underlined()
        passwordField.underlined()
        
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
