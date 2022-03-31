import Foundation
import SQLite

public class AuthorizationService {
    fileprivate let _usersTable = Table("users")
    
    fileprivate let _idExpression = Expression<Int>("id")
    fileprivate let _loginExpression = Expression<String>("login")
    fileprivate let _passwordExpression = Expression<String>("password")
    
    public static let shared = AuthorizationService()
    
    private init() {
        createTable()
    }
    
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
