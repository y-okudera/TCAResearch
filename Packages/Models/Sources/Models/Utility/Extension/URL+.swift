//
//  URL+.swift
//  
//
//  Created by okudera on 2022/11/30.
//

import UIKit

extension URL {

    static func localURLForXCAsset(
        name: String,
        in bundle: Bundle,
        fileManager: FileManager = .default
    ) -> URL? {
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        if !fileManager.fileExists(atPath: path) {
            guard let image = UIImage(named: name, in: bundle, with: nil), let data = image.pngData() else {
                return nil
            }
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
        }
        return url
    }
}
