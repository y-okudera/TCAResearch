//
//  InfiniteCarouselItem.swift
//
//
//  Created by Yuki Okudera on 2022/10/11.
//

import Foundation
import Models

// MARK: - InfiniteCarouselItem
struct InfiniteCarouselItem: Identifiable {

    let id: UUID
    let item: Item
    let isFavorite: Bool

    init(
        id: UUID,
        item: Item,
        isFavorite: Bool
    ) {
        self.id = id
        self.item = item
        self.isFavorite = isFavorite
    }
}
