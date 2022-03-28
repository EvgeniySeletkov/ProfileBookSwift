import UIKit

public class SignUpViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
