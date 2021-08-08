//
//  IconModel.swift
//  TimePad
//
//  Created by Anday on 25.07.21.
//

import Foundation

struct Icon: Codable, Identifiable {
    var id = UUID().uuidString
    var imageName: String
    let backgroundColor: String
}
