import UIKit

public class MenuListViewController: UIViewController {
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
    }
    
    @IBAction func onAddProfileTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToAddEditProfile", sender: nil)
    }
}

extension MenuListViewController: UITableViewDataSource, UITableViewDelegate{
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
}
