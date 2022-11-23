//
//  DatabaseError.swift
//
//
//  Created by Yuki Okudera on 2022/10/23.
//

import Foundation

// MARK: - DatabaseError
public enum DatabaseError: Error {
    /// 保存失敗
    case failedToSave(Error)
    /// 新規保存失敗
    case failedToCreate(Error)
    /// 削除失敗
    case failedToDelete(Error)
}

// MARK: LocalizedError
extension DatabaseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToSave:
            return "データの保存または更新に失敗しました。"
        case .failedToCreate:
            return "データの保存に失敗しました。"
        case .failedToDelete:
            return "データの削除に失敗しました。"
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case let .failedToSave(error):
            return (error as NSError).localizedRecoverySuggestion
        case let .failedToCreate(error):
            return (error as NSError).localizedRecoverySuggestion
        case let .failedToDelete(error):
            return (error as NSError).localizedRecoverySuggestion
        }
    }
}

// MARK: CustomNSError
extension DatabaseError: CustomNSError {

    /// The domain of the error.
    public static var errorDomain: String {
        "Models.DatabaseError"
    }

    /// The error code within the given domain.
    public var errorCode: Int {
        switch self {
        case .failedToSave:
            return 0
        case .failedToCreate:
            return 1
        case .failedToDelete:
            return 2
        }
    }

    /// The user-info dictionary.
    public var errorUserInfo: [String: Any] {
        switch self {
        case let .failedToSave(error):
            return (error as NSError).userInfo
        case let .failedToCreate(error):
            return (error as NSError).userInfo
        case let .failedToDelete(error):
            return (error as NSError).userInfo
        }
    }
}

// MARK: Equatable
extension DatabaseError: Equatable {
    public static func == (lhs: DatabaseError, rhs: DatabaseError) -> Bool {
        switch (lhs, rhs) {
        case let (.failedToSave(lError), .failedToSave(rError)):
            return (lError as NSError).isEqual(to: rError as NSError)
        case let (.failedToCreate(lError), .failedToCreate(rError)):
            return (lError as NSError).isEqual(to: rError as NSError)
        case let (.failedToDelete(lError), .failedToDelete(rError)):
            return (lError as NSError).isEqual(to: rError as NSError)
        default:
            return false
        }
    }
}
