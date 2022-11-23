//
//  UserView.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import Kingfisher
import Models
import SwiftUI

public struct UserView: View {

    let user: User

    public init(user: User) {
        self.user = user
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            Spacer()
                .frame(width: 16.0)
            if let url = URL(string: user.profileImageUrl) {
                KFImage(url)
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60.0, height: 60.0)
                    .aspectRatio(contentMode: .fit)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(user.name.isEmpty ? (user.githubLoginName ?? user.twitterScreenName ?? "") : user.name)
                    .font(.headline)
                    .lineLimit(1)
                Text("followees: \(user.followeesCount) followers: \(user.followersCount)")
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {

    static var previews: some View {
        UserView(user: .mock)
    }
}
