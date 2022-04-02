import UIKit
import SQLite

public class SignInViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onSignedUp(notification:)), name: Notification.Name(Constants.NotificationCenter.SIGN_UP), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func onSignedUp(notification: Notification) {
        loginTextField.text = notification.object as? String
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
            NotificationCenter.default.removeObserver(self)
            
            let mainListNC = storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllers.MAIN_LIST_NAVIGATION_CONTROLLER) as! MainListNavigationController

            view.window?.rootViewController = mainListNC
            view.window?.makeKeyAndVisible()
        }
        else {
            showAlert(message: NSLocalizedString("InvalidLoginOrPassword", comment: ""))
        }
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: Constants.Navigation.GO_TO_SIGN_UP, sender: nil)
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
