import Foundation
import RealmSwift

public final class DatabaseService {
    var readRealm: Realm!
    var newRealm: Realm {
        let configuration = self.makeContactConfiguration(readOnly: false)
        return try! Realm(configuration: configuration)
    }
    
    public init() {
        let configuration = self.makeContactConfiguration(readOnly: false)
        self.readRealm = try! Realm(configuration: configuration)
    }
}


private extension DatabaseService {
    func makeContactConfiguration(readOnly: Bool) -> Realm.Configuration {
        let config = Realm.Configuration(
            fileURL: contactsFileUrl(),
            schemaVersion: 1)
        return config
    }
    
    func contactsFileUrl() -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("dogbreeds.realm")
    }
}
