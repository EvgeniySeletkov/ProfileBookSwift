import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
