import UIKit

public class ProfileViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNickName: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileDateTime: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setProfile(profile: ProfileModel){
        let image = UIImage(named: "pic_profile")
        profileImage.image = image
        profileNickName.text = profile.nickname
        profileName.text = profile.name
        profileDateTime.text = profile.dateTime
    }
}
