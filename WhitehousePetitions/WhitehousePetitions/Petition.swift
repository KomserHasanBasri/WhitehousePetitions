//
//  Petitons.swift
//  WhitehousePetitions
//
//  Created by Hasan Basri Komser on 23.03.2023.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body : String
    var signatureCount: Int
}
