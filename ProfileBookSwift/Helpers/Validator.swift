import Foundation

public struct Validator {
    public static func checkIsLoginValid(login: String?) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", "^[A-Za-z][A-Za-z\\d]{3,15}").evaluate(with: login)
    }
    
    public static func checkIsPasswordValid(password: String?) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", "^[A-Z](?=.*[a-z])(?=.*\\d)[a-zA-Z\\d]{7,15}").evaluate(with: password)
    }
}
