import UIKit

public class AddEditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private let _imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    public var profile: ProfileModel = ProfileModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _imagePicker.delegate = self
        _imagePicker.allowsEditing = true
        let imageTapAction = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
        imageView.addGestureRecognizer(imageTapAction)
        imageView.isUserInteractionEnabled = true
        
        if !profile.image.isEmpty {
            imageView.image = ImageService.shared.loadImage(fileName: profile.image)
        }
        nicknameTextField.text = profile.nickname
        nameTextField.text = profile.name
        descriptionTextView.text = profile.description
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            profile.image = ImageService.shared.saveImage(image: pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveProfileTapped(_ sender: Any) {
        profile.nickname = nicknameTextField.text!
        profile.name = nameTextField.text!
        profile.description = descriptionTextView.text
        profile.dateTime = "Today"
        profile.userId = 1
        
        if !hasEmptyFields() {
            if profile.id == 0 {
                ProfileService.shared.addProfile(profile)
            }
            else {
                ProfileService.shared.updateProfile(profile)
            }
            
            NotificationCenter.default.post(name: Notification.Name("SaveProfile"), object: true)
            
            navigationController?.popViewController(animated: true)
        }
        else {
            showAlert(message: "NickName or Name field is empty!")
        }
    }
    
    @objc private func onImageTapped(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self._imagePicker.sourceType = .camera
            self.pickImage()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { action in
            self._imagePicker.sourceType = .photoLibrary
            self.pickImage()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func pickImage() {
        present(_imagePicker, animated: true, completion: nil)
    }
    
    private func hasEmptyFields() -> Bool {
        return nicknameTextField.text!.isEmpty || nameTextField.text!.isEmpty
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
