import UIKit

public class MainListViewController: UIViewController {
    private var _profiles: [ProfileModel] = ProfileService.shared.getProfilesByUserId()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noProfilesLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 45
        addButton.layer.borderWidth = 8
        addButton.layer.borderColor = UIColor.darkGray.cgColor
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.PROFILE_VIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.PROFILE_VIEW_CELL)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdateProfileList(notification:)), name: Notification.Name(Constants.NotificationCenter.SAVE_PROFILE), object: nil)
        
        noProfilesLabel.isHidden = !_profiles.isEmpty
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func onUpdateProfileList(notification: Notification) {
        _profiles = ProfileService.shared.getProfilesByUserId()
        tableView.reloadData()
        
        noProfilesLabel.isHidden = !_profiles.isEmpty
    }
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("LogOutAlertMessage", comment: ""), preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: nil)
        
        let yesAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default) { action in
            self.logOut()
        }
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onAddProfileTapped(_ sender: Any) {
        performSegue(withIdentifier: Constants.Navigation.GO_TO_ADD_EDIT_PROFILE, sender: nil)
    }
    
    private func logOut() {
        AuthorizationService.shared.logOut()
        
        let signInNC = storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllers.SIGN_IN_NAVIGATION_CONTROLLER) as! SignInNavigationController

        view.window?.rootViewController = signInNC
        view.window?.makeKeyAndVisible()
    }
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _profiles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PROFILE_VIEW_CELL, for: indexPath) as! ProfileViewCell
        
        let profile = _profiles[indexPath.row]
        cell.setProfile(profile: profile)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: {
            suggestedActions in
            
            let editAction = UIAction(title: NSLocalizedString(NSLocalizedString("Edit", comment: ""), comment: "")) { action in
                let addEditVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllers.ADD_EDIT_PROFILE_VIEW_CONTROLLER) as! AddEditProfileViewController
                
                addEditVC.title = NSLocalizedString("EditProfile", comment: "")
                addEditVC.profile = self._profiles[indexPath.row]
                self.show(addEditVC, sender: nil)
            }
            
            let deleteAction = UIAction(title: NSLocalizedString("Delete", comment: ""), attributes: .destructive) { action in
                self.deleteProfileByIndex(index: indexPath.row)
                
                tableView.reloadData()
                self.noProfilesLabel.isHidden = !self._profiles.isEmpty
            }
            
            return UIMenu(title: "", children: [editAction, deleteAction])
        })
    }
    
    private func deleteProfileByIndex(index: Int) {
        let profile = self._profiles[index]
        
        ProfileService.shared.deleteProfile(profile)
        self._profiles.remove(at: index)
    }
}
