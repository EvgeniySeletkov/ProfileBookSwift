import UIKit
import SQLite

public class SignInViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginChanged(_ sender: Any) {
        signInButton.isEnabled = !checkFieldsAreEmpty()
    }
    
    @IBAction func onPasswordChanged(_ sender: Any) {
        signInButton.isEnabled = !checkFieldsAreEmpty()
    }
    
    @IBAction func onSignInTapped(_ sender: Any) {
        let isAuthorized = AuthorizationService.shared.signIn(login: loginTextField.text!, password: passwordTextField.text!)
        
        if isAuthorized {
            let mainListNC = storyboard?.instantiateViewController(withIdentifier: "MainListNavigationController") as! MainListNavigationController

            view.window?.rootViewController = mainListNC
            view.window?.makeKeyAndVisible()
        }
        else {
            showAlert(message: NSLocalizedString("InvalidLoginOrPassword", comment: ""))
        }
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToSignUp", sender: nil)
    }
    
    private func checkFieldsAreEmpty() -> Bool {
        return loginTextField.text!.isEmpty
        || passwordTextField.text!.isEmpty
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }

}
