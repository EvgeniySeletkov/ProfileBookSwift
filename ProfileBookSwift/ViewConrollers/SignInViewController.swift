import UIKit
import SQLite

public class SignInViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSignInTapped(_ sender: Any) {
        let mainListNC = storyboard?.instantiateViewController(withIdentifier: "MainListNavigationController") as! MainListNavigationController

        view.window?.rootViewController = mainListNC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToSignUp", sender: nil)
    }

}
