import Foundation
import SQLite

public class Database {
    public static let shared = Database()
    
    public fileprivate (set) var connection: Connection!
    
    private init(){
        connect()
    }
    
    private func connect() {
        guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                             .userDomainMask,
                                                             true).first else {
            return
        }
        
        do {
            connection = try Connection("\(path)/db.sqlite3")
        }
        catch {
            print(error)
        }
    }
}
