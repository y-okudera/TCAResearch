//
//  SnapshotDevices.swift
//  
//
//  Created by Yuki Okudera on 2022/11/29.
//

import SnapshotTesting

public enum SnapshotDevices: String, CaseIterable {
    case iPhone13ProMax
    case iPhone13
    case iPhone8Plus
    case iPhoneSe

    public var layout: SwiftUISnapshotLayout {
        switch self {
        case .iPhone13ProMax:
            return .device(config: .iPhone13ProMax)
        case .iPhone13:
            return .device(config: .iPhone13)
        case .iPhone8Plus:
            return .device(config: .iPhone8Plus)
        case .iPhoneSe:
            return .device(config: .iPhoneSe)
        }
    }
}
