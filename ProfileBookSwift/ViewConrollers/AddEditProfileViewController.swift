import UIKit

public class AddEditProfileViewController: UIViewController {
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSaveProfileTapped(_ sender: Any) {
        let profile = ProfileModel(nickname: nicknameTextField.text!, name: nameTextField.text!, dateTime: "Today", description: descriptionTextView.text, userId: 1)

        ProfileService.shared.addProfile(profile)

        navigationController?.popViewController(animated: true)
    }
}
