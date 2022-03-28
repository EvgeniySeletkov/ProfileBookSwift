import UIKit
import SQLite

public class SignInViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSignInTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToMainList", sender: nil)
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToSignUp", sender: nil)
    }

}
