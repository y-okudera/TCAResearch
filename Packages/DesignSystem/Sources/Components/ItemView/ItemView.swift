//
//  ItemView.swift
//
//
//  Created by Yuki Okudera on 2022/10/16.
//

import Kingfisher
import Models
import SwiftUI

// MARK: - ItemView
public struct ItemView: View {

    let item: Item

    public init(item: Item) {
        self.item = item
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Spacer()
                .frame(width: 16.0)
            if let url = URL(string: item.user.profileImageUrl) {
                KFImage(url)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80.0, height: 80.0)
                    .aspectRatio(contentMode: .fit)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(item.user.name)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

// MARK: - ItemView_Previews
struct ItemView_Previews: PreviewProvider {

    static var previews: some View {
        ItemView(item: .mock)
    }
}
