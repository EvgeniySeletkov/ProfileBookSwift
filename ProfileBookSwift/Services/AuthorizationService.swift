import Foundation
import SQLite

public class AuthorizationService {
    private let _usersTable = Table("users")
    
    private let _idExpression = Expression<Int>("id")
    private let _loginExpression = Expression<String>("login")
    private let _passwordExpression = Expression<String>("password")
    
    public static let shared = AuthorizationService()
    
    init() {
        createTable()
    }
    
    public var isAuthorized = SettingsManager.shared.userId != 0
    
    public func checkIsUserExist(login: String) -> Bool {
        var result = false
        
        do {
            for user in try Database.shared.connection.prepare(_usersTable) {
                if user[_loginExpression] == login {
                    result = true
                }
            }
        }
        catch {
            print(error)
        }
        
        return result
    }
    
    public func signIn(login: String, password: String) -> Bool {
        var result = false
        
        do {
            for user in try Database.shared.connection.prepare(_usersTable) {
                if user[_loginExpression] == login && user[_passwordExpression] == password {
                    result = true
                    SettingsManager.shared.userId = user[_idExpression]
                }
            }
        }
        catch {
            print(error)
        }
        
        return result
    }
    
    public func signUp(user: UserModel) {
        do {
            try Database.shared.connection.run(_usersTable.insert(_loginExpression <- user.login, _passwordExpression <- user.password))
        }
        catch {
            print(error)
        }
    }
    
    public func logOut() {
        SettingsManager.shared.clearSettings()
    }
    
    private func createTable() {
        do {
            try Database.shared.connection.run(_usersTable.create(ifNotExists: true) { p in
                p.column(_idExpression, primaryKey: .autoincrement)
                p.column(_loginExpression)
                p.column(_passwordExpression)
            })
        }
        catch {
            print(error)
        }
    }
}
