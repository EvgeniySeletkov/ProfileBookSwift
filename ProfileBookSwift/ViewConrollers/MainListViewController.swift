import UIKit

public class MainListViewController: UIViewController {
    private var _profiles: [ProfileModel] = ProfileService.shared.getProfilesByUserId()
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addButton.layer.cornerRadius = 45
        addButton.layer.borderWidth = 8
        addButton.layer.borderColor = UIColor.darkGray.cgColor
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileViewCell", bundle: nil), forCellReuseIdentifier: "ProfileViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdateProfileList(notification:)), name: Notification.Name("SaveProfile"), object: nil)
    }
    
    @objc func onUpdateProfileList(notification: Notification) {
        _profiles = ProfileService.shared.getProfilesByUserId()
        tableView.reloadData()
    }
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        let signInNC = storyboard?.instantiateViewController(withIdentifier: "SignInNavigationController") as! SignInNavigationController

        view.window?.rootViewController = signInNC
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func onAddProfileTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToAddEditProfile", sender: nil)
    }
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _profiles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell
        
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
            
            let editAction = UIAction(title: NSLocalizedString("Edit", comment: "")) { action in
                let addEditVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEditProfileViewController") as! AddEditProfileViewController
                
                addEditVC.profile = self._profiles[indexPath.row]
                self.show(addEditVC, sender: nil)
            }
            
            let deleteAction = UIAction(title: NSLocalizedString("Delete", comment: ""), attributes: .destructive) { action in
                self.deleteProfileByIndex(index: indexPath.row)
                
                tableView.reloadData()
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
