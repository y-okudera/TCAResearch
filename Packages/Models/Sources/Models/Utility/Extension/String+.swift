//
//  String+.swift
//  
//
//  Created by Yuki Okudera on 2022/11/23.
//

import Foundation

extension String {

    func convertToDate(format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        guard let date = formatter.date(from: self) else {
            fatalError("Failed to convert.")
        }
        return date
    }
}
