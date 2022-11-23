//
//  Realm+.swift
//
//
//  Created by Yuki Okudera on 2022/10/23.
//

import Foundation
import Models
import RealmSwift

extension Realm {

    public func fetch<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> Results<T> {
        let objects = self.objects(type)
        if let predicate {
            return objects.filter(predicate)
        }
        return objects
    }

    public func save<T: Object>(_ type: T.Type, value: [String: Any]) throws {
        do {
            try self.write {
                self.create(type, value: value, update: .modified)
            }
        } catch {
            throw DatabaseError.failedToSave(error)
        }
    }

    public func save<T: Object>(_ object: T) throws {
        do {
            try self.write {
                self.create(T.self, value: object, update: .modified)
            }
        } catch {
            throw DatabaseError.failedToSave(error)
        }
    }

    public func create<T: Object>(_ type: T.Type, object: T) throws {
        do {
            try self.write {
                self.add(object)
            }
        } catch {
            throw DatabaseError.failedToCreate(error)
        }
    }

    public func delete<T: Object>(_ type: T.Type, id: UUID) throws {
        do {
            try self.write {
                self.delete(self.objects(type).filter("id == %@", id))
            }
        } catch {
            throw DatabaseError.failedToDelete(error)
        }
    }
}
