

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nametextField.underlined()
        emailField.underlined()
        passwordField.underlined()
        userImage.setRadius()
        
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
