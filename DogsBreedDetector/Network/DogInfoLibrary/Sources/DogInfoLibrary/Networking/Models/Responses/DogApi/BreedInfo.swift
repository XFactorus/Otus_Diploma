import Foundation
import RealmSwift

public class BreedInfo: Object, Codable, Identifiable {
    @objc public dynamic var id: Int = 0
    @objc public dynamic var name: String = ""
    @objc public dynamic var lifeSpan: String = ""
    @objc public dynamic var temperament: String?
    @objc public dynamic var weight: BreedWeight?
    @objc public dynamic var height: BreedHeight?
    
    public override init() {}
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name, temperament, weight, height
        case lifeSpan = "life_span"
    }
    
    public convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
        self.temperament = try? container.decode(String?.self, forKey: .temperament)
        self.weight = try? container.decode(BreedWeight?.self, forKey: .weight)
        self.height = try? container.decode(BreedHeight?.self, forKey: .height)
    }
    
    public override class func primaryKey() -> String? {
        return BreedInfo.getPrimaryKey()
    }
    
    public static func getPrimaryKey() -> String {
        return "id"
    }
    
    
    public static func getMockBreed() -> BreedInfo {
        let breed = BreedInfo()
        breed.id = 195
        breed.name = "Poodle"
        breed.lifeSpan = "14-18 years"
        breed.temperament = "Alert, Intelligent, Faithful, Active, Instinctual, Trainable"
        return breed
    }
    
}

@objc public class BreedWeight: Object, Codable {
    @objc public dynamic var imperial: String = ""
    @objc public dynamic var metric: String = ""
}

@objc public class BreedHeight: Object, Codable {
    @objc public dynamic var imperial: String = ""
    @objc public dynamic var metric: String = ""
}
