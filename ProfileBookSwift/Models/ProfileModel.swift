import Foundation

struct ProfileModel {
    var image: String?
    var nickname: String
    var name: String
    var dateTime: String
}

class ProfileList{
    var profiles = [ProfileModel]()
    
    init() {
        setup()
    }
    
    func setup() {
        profiles = [
            ProfileModel(image: nil, nickname: "ABC", name: "abc", dateTime: "Today"),
            ProfileModel(image: nil, nickname: "BAC", name: "bac", dateTime: "Today"),
            ProfileModel(image: nil, nickname: "CAB", name: "cab", dateTime: "Today")
        ]
    }
}
