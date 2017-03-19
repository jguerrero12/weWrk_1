

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn


class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
 
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.underlined()
        passwordField.underlined()
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // Facebook login button tapped
    @IBAction func facebookLogin(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            // Error handling
            if error != nil {
                print("LUIS: Unable to authenticate with facebook")
            } else if result?.isCancelled == true {
                print("User cancelled Facebook Authentication")
            } else {
                print("LUIS: Authentication successful")
                
                // Gets credential from Access token from firebase
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)    
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth (_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
            print("Unable to authenticate with Firebase")
            } else {
                self.completeSignIn()
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwdField = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwdField, completion: { (user, error) in
                if error == nil {
                    self.completeSignIn()
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwdField, completion: { (user, error) in
                        if error != nil {
                            print("Unable to auth with Firebase")
                        } else {
                            print("Successfully auth with Firebase")
                        }
                    })
                }
            })
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("error with Google Sign In \(error.localizedDescription)")
            return
        }
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        
        FIRAuth.auth()?.signIn(with: credential, completion: {(user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            return
            print("Logged in with Google")
            
        })
    }

    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("error with Google Log Out \(error.localizedDescription)")
            return
        }
    }
    
    func completeSignIn() {
        performSegue(withIdentifier: "feed", sender: nil)
        
    }
}
