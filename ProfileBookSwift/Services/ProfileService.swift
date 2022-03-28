import Foundation
import SQLite
import CoreText

public class ProfileService {
    fileprivate let _profilesTable = Table("profiles")
    
    fileprivate let _idExpression = Expression<Int>("id")
    fileprivate let _imageExpression = Expression<String>("image")
    fileprivate let _nicknameExpression = Expression<String>("nickname")
    fileprivate let _nameExpression = Expression<String>("name")
    fileprivate let _descriptionExpression = Expression<String>("description")
    fileprivate let _dateTimeExpression = Expression<String>("dateTime")
    fileprivate let _userIdExpression = Expression<Int>("userId")
    
    public static let shared = ProfileService()
    
    private init() {
        createTable()
    }
    
    public func addProfile(_ profile: ProfileModel){
        do {
            try Database.shared.connection.run(_profilesTable.insert(_imageExpression <- profile.image, _nicknameExpression <- profile.nickname, _nameExpression <- profile.name, _descriptionExpression <- profile.description, _dateTimeExpression <- profile.dateTime, _userIdExpression <- profile.userId))
        }
        catch {
            print(error)
        }
    }
    
    public func updateProfile(_ profile: ProfileModel){
        do {
            try Database.shared.connection.run(_profilesTable.update(
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
            let filter = _profilesTable.filter(_userIdExpression == 1)
            
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
                p.column(_idExpression, primaryKey: true)
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
