import SwiftUI

import CoreData

class DataManager {
    static let shared = DataManager()

    let dataContainer: NSPersistentContainer

    init() {
        dataContainer = NSPersistentContainer(name: "DataModel")
        dataContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки хранилища: \(error)")
            }
        }
    }
    private func deleteOldData(entityName: String) {
        let context = dataContainer.viewContext
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        do {
            let existingItems = try context.fetch(fetchRequest)
            existingItems.forEach { context.delete($0) }
        } catch {
            print("Ошибка при удалении данных из \(entityName): \(error)")
        }
    }

    func fetchLastUpdated() -> Date? {
        let context = dataContainer.viewContext
        let fetchRequest: NSFetchRequest<NSManagedObject> =
        NSFetchRequest(entityName: "TimestampEntity")

        do {
            let results = try context.fetch(fetchRequest)
            if let timestamp = results.first {
                return timestamp.value(forKey: "lastUpdated") as? Date
            }
            return nil
        } catch {
            print("Ошибка извлечения времени последнего обновления: \(error)")
            return nil
        }
    }
    func saveUser(name: String) {
        saveEntity(name: name, entityName: "UserEntity", values: ["name": name])
    }

    func saveFriends(_ friends: [Friend]) {
        deleteOldData(entityName: "FriendEntity")
        friends.forEach { friend in
            saveEntity(name: friend.firstName, entityName: "FriendEntity", values: [
                "id": friend.id,
                "firstName": friend.firstName,
                "lastName": friend.lastName,
                "online": friend.online
            ])
        }
        saveTimestamp()
    }

    func saveGroups(_ groups: [Group]) {
        deleteOldData(entityName: "GroupEntity")
        groups.forEach { group in
            saveEntity(name: group.name, entityName: "GroupEntity", values: [
                "id": group.id,
                "name": group.name
            ])
        }
    }

    private func saveEntity(name: String, entityName: String, values: [String: Any]) {
        let context = dataContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let object = NSManagedObject(entity: entity, insertInto: context)

        values.forEach { key, value in
            object.setValue(value, forKey: key)
        }

        do {
            try context.save()
        } catch {
            print("Ошибка сохранения \(entityName): \(error)")
        }
    }

    private func saveTimestamp() {
        let context = dataContainer.viewContext
        let timestampEntity = NSEntityDescription.entity(forEntityName: "TimestampEntity", in: context)!
        let timestampObject = NSManagedObject(entity: timestampEntity, insertInto: context)
        timestampObject.setValue(Date(), forKey: "lastUpdated")

        do {
            try context.save()
        } catch {
            print("Ошибка сохранения времени последнего обновления: \(error)")
        }
    }

    func fetchFriends() -> [Friend] {
        return fetchEntity(entityName: "FriendEntity") { friend in
            guard let id = friend.value(forKey: "id") as? Int,
                  let firstName = friend.value(forKey: "firstName") as? String,
                  let lastName = friend.value(forKey: "lastName") as? String,
                  let online = friend.value(forKey: "online") as? Int else { return nil }
            return Friend(id: id, firstName: firstName, lastName: lastName, online: online)
        }
    }

    func fetchGroups() -> [Group] {
        return fetchEntity(entityName: "GroupEntity") { group in
            guard let id = group.value(forKey: "id") as? Int,
                  let name = group.value(forKey: "name") as? String else { return nil }
            return Group(id: id, name: name)
        }
    }

    private func fetchEntity<T>(entityName: String, map: (NSManagedObject) -> T?) -> [T] {
        let context = dataContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)

        do {
            let results = try context.fetch(fetchRequest)
            return results.compactMap(map)
        } catch {
            print("Ошибка извлечения данных из \(entityName): \(error)")
            return []
        }
    }
}
