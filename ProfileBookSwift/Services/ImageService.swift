import Foundation
import UIKit

public class ImageService {
    private let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    public static let shared = ImageService()
    
    public func saveImage(image: UIImage) -> String {
        var result = ""
        
        do {
            let fileName = UUID().uuidString
            let filePath = documentsUrl.appendingPathComponent(fileName)
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                try imageData.write(to: filePath, options: .atomic)
                result = fileName
            }
        }
        catch {
            print(error)
        }
        
        return result
    }
    
    public func loadImage(fileName: String) -> UIImage? {
        var result: UIImage? = nil
        
        do {
            let filePath = documentsUrl.appendingPathComponent(fileName)
            let imageData = try Data(contentsOf: filePath)
            result = UIImage(data: imageData)
        }
        catch {
            print(error)
        }
        
        return result
    }

}
