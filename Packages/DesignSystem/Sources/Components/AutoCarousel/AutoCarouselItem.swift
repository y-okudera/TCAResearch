//
//  AutoCarouselItem.swift
//
//
//  Created by Yuki Okudera on 2022/10/10.
//

import Foundation
import Models

// MARK: - AutoCarouselItem
struct AutoCarouselItem: Identifiable {

    let id: UUID
    let item: Item

    init(
        id: UUID,
        item: Item
    ) {
        self.id = id
        self.item = item
    }
}
