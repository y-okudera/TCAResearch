//
//  AutoCarouselView.swift
//
//
//  Created by Yuki Okudera on 2022/10/10.
//

import ACarousel
import Kingfisher
import Logger
import Models
import SwiftUI

// MARK: - AutoCarouselView
public struct AutoCarouselView: View {

    private let items: [AutoCarouselItem]
    private let onTap: (Item) -> Void

    public init(
        data: [Item],
        onTap: @escaping (Item) -> Void
    ) {
        self.items = data.map { .init(id: .init(), item: $0) }
        self.onTap = onTap
    }

    public var body: some View {
        ACarousel(
            items,
            spacing: 10,
            headspace: 10,
            sidesScaling: 0.7,
            isWrap: true,
            autoScroll: .active(5)
        ) { item in
            if let url = URL(string: item.item.user.profileImageUrl) {
                KFImage(url)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(30)
                    .contentShape(RoundedRectangle(cornerRadius: 30))
                    .onTapGesture {
                        onTap(item.item)
                    }
            } else {
                ProgressView().frame(height: 300)
            }
        }
        .frame(height: 300)
    }
}

// MARK: - AutoCarouselView_Previews
struct AutoCarouselView_Previews: PreviewProvider {

    static var previews: some View {
        AutoCarouselView(data: [Item].mock) { _ in }
    }
}
