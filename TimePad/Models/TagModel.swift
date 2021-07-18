//
//  TagModel.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import Foundation


struct Tag: Codable, Identifiable {
    var id = UUID().uuidString
    let name: String
    let fontColor: String
}
