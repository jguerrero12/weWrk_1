
import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        //  Firebase Configuration:
        FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Persistant ligin
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let tab = mainStoryBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        let login = mainStoryBoard.instantiateViewController(withIdentifier: "login") as! LoginViewController
      // Persistant ligin
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil {
                // User is signed in.
                self.window?.rootViewController = tab
            } else {
                self.window?.rootViewController = login
            }
        })
        
            
        return true
    }
    //Google Log In: Brings you to Google URL
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    
    
    

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    } 

}

