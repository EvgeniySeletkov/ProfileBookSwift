import Foundation

public class SettingsManager {
    public static let shared = SettingsManager()
    
    public var userId: Int {
        get { UserDefaults.standard.integer(forKey: "UserId") }
        set { UserDefaults.standard.set(newValue, forKey: "UserId") }
    }
    
    public func clearSettings() {
        userId = 0
    }
}
