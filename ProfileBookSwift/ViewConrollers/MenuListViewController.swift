import UIKit

class MenuListViewController: UIViewController {
    private var _profileList: ProfileList = ProfileList()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProfileViewCell", bundle: nil), forCellReuseIdentifier: "ProfileViewCell")
    }
}

extension MenuListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _profileList.profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell
        
        let profile = _profileList.profiles[indexPath.row]
        cell.setProfile(profile: profile)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
