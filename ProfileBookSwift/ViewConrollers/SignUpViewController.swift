import UIKit

public class SignUpViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginChanged(_ sender: Any) {
        signUpButton.isEnabled = !checkFieldsAreEmpty()
    }
    
    @IBAction func onPasswordChanged(_ sender: Any) {
        signUpButton.isEnabled = !checkFieldsAreEmpty()
    }
    
    @IBAction func onConfirmPasswordChanged(_ sender: Any) {
        signUpButton.isEnabled = !checkFieldsAreEmpty()
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        if checkIsLogin() && checkIsPassword() {
            if passwordTextField.text == confirmPasswordTextField.text {
                let isUserExist = AuthorizationService.shared.checkIsUserExist(login: loginTextField.text!)

                if !isUserExist {
                    let user = UserModel(
                        login: loginTextField.text!,
                        password: passwordTextField.text!)

                    AuthorizationService.shared.signUp(user: user)

                    navigationController?.popViewController(animated: true)
                }
                else {
                    showAlert(message: NSLocalizedString("ThisLoginIsBusy", comment: ""))
                }
            }
            else {
                showAlert(message: NSLocalizedString("PasswordsFieldsNotMatches", comment: ""))
            }
        }
    }
    
    private func checkFieldsAreEmpty() -> Bool {
        return loginTextField.text!.isEmpty
        || passwordTextField.text!.isEmpty
        || confirmPasswordTextField.text!.isEmpty
    }
    
    private func checkIsLogin() -> Bool {
        var result = false
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", "^[A-Za-z][A-Za-z\\d]{3,15}")
        
        if predicate.evaluate(with: loginTextField.text) {
            result = true
        }
        else {
            showAlert(message: NSLocalizedString("LoginIsInvalid", comment: ""))
        }
        
        return result
    }
    
    private func checkIsPassword() -> Bool {
        var result = false
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", "^[A-Z](?=.*[a-z])(?=.*\\d)[a-zA-Z\\d]{7,15}")
        
        if predicate.evaluate(with: passwordTextField.text) {
            result = true
        }
        else {
            showAlert(message: NSLocalizedString("PasswordIsInvalid", comment: ""))
        }
        
        return result
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
