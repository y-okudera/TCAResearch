//
//  InfiniteCarouselView.swift
//
//
//  Created by Yuki Okudera on 2022/10/10.
//

import ACarousel
import Kingfisher
import Logger
import Models
import SwiftUI

// MARK: - InfiniteCarouselView
public struct InfiniteCarouselView: View {

    private let items: [InfiniteCarouselItem]
    private let onTap: (Item) -> Void
    private let onTapFavorite: (Item) -> Void

    public init(
        data: [(item: Item, isFavorite: Bool)],
        onTap: @escaping (Item) -> Void,
        onTapFavorite: @escaping (Item) -> Void
    ) {
        self.items = data
            .map { .init(id: .init(), item: $0.item, isFavorite: $0.isFavorite) }
        self.onTap = onTap
        self.onTapFavorite = onTapFavorite
    }

    public var body: some View {
        ACarousel(
            items,
            spacing: 16,
            headspace: 96,
            sidesScaling: 1.0,
            isWrap: true
        ) { item in
            VStack(spacing: 4.0) {
                if let url = URL(string: item.item.user.profileImageUrl) {
                    KFImage(url)
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                } else {
                    ProgressView().frame(height: 100)
                }

                HStack {
                    Text(item.item.title)
                        .font(.body)
                        .lineLimit(2)
                    Spacer()
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                        .font(.title)
                        .onTapGesture {
                            onTapFavorite(item.item)
                        }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onTap(item.item)
            }
        }
        .frame(height: 150)
    }
}

// MARK: - InfiniteCarouselView_Previews
struct InfiniteCarouselView_Previews: PreviewProvider {

    static var previews: some View {
        InfiniteCarouselView(
            data: [Item].mock.map { ($0, true) },
            onTap: { _ in },
            onTapFavorite: { _ in }
        )
    }
}
