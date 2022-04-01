import Foundation
import SQLite

public class ProfileService {
    private let _profilesTable = Table("profiles")
    
    private let _idExpression = Expression<Int>("id")
    private let _imageExpression = Expression<String>("image")
    private let _nicknameExpression = Expression<String>("nickname")
    private let _nameExpression = Expression<String>("name")
    private let _descriptionExpression = Expression<String>("description")
    private let _dateTimeExpression = Expression<String>("dateTime")
    private let _userIdExpression = Expression<Int>("userId")
    
    public static let shared = ProfileService()
    
    init() {
        createTable()
    }
    
    public func addProfile(_ profile: ProfileModel){
        do {
            let userId = SettingsManager.shared.userId
            
            try Database.shared.connection.run(_profilesTable.insert(_imageExpression <- profile.image, _nicknameExpression <- profile.nickname, _nameExpression <- profile.name, _descriptionExpression <- profile.description, _dateTimeExpression <- profile.dateTime, _userIdExpression <- userId))
        }
        catch {
            print(error)
        }
    }
    
    public func updateProfile(_ profile: ProfileModel){
        do {
            let filter = _profilesTable.filter(_idExpression == profile.id)
            
            try Database.shared.connection.run(filter.update(
                _imageExpression <- profile.image,
                _nicknameExpression <- profile.nickname,
                _nameExpression <- profile.name,
                _descriptionExpression <- profile.description,
                _dateTimeExpression <- profile.dateTime))
        }
        catch {
            print(error)
        }
    }
    
    public func deleteProfile(_ profile: ProfileModel){
        do {
            let filter = _profilesTable.filter(_idExpression == profile.id)
            
            try Database.shared.connection.run(filter.delete())
        }
        catch {
            print(error)
        }
    }
    
    public func getProfilesByUserId() -> [ProfileModel]{
        var result = [ProfileModel]()
        
        do {
            let filter = _profilesTable.filter(_userIdExpression == SettingsManager.shared.userId)
            
            for profile in try Database.shared.connection.prepare(filter) {
                result.append(ProfileModel(
                    id: profile[_idExpression],
                    image: profile[_imageExpression],
                    nickname: profile[_nicknameExpression],
                    name: profile[_nameExpression],
                    dateTime: profile[_dateTimeExpression],
                    description: profile[_descriptionExpression],
                    userId: profile[_userIdExpression]))
            }
        }
        catch {
            print(error)
        }
        
        return result
    }
    
    private func createTable() {
        do {
            try Database.shared.connection.run(_profilesTable.create(ifNotExists: true) { p in
                p.column(_idExpression, primaryKey: .autoincrement)
                p.column(_imageExpression)
                p.column(_nicknameExpression)
                p.column(_nameExpression)
                p.column(_descriptionExpression)
                p.column(_dateTimeExpression)
                p.column(_userIdExpression)
            })
        }
        catch {
            print(error)
        }
    }
}
