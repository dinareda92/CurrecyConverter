//
//  CurrencyResponseModel.swift
//  CurrencyConverter
//
//  Created by Dina Reda on 6/25/22.
//

import Foundation

// MARK: - Latest
struct Latest: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: [String: Double]?
}

// MARK: - LatestElement
struct LatestElement: Codable {
    let key: String?
    let value: Double?
}


// MARK: - HistoryRecordElement
struct HistoryRecordElement: Codable {
    let date, from, to: String?
}

typealias HistoryRecord = [HistoryRecordElement]
