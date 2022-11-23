//
//  Array+.swift
//
//
//  Created by Yuki Okudera on 2022/10/10.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
