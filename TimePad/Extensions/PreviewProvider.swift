//
//  PreviewProvider.swift
//  TimePad
//
//  Created by Anday on 18.07.21.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}


class DeveloperPreview {
    
    
    static let instance = DeveloperPreview()
    
    private init() {}
    
    let task = Task(title: "Learn IOS", date: Date(), durationSeconds: 3600, icon: "monitor", backgroundColor: "9B51E0", tags: [Tag(name: "Work", fontColor: "FD5B71"), Tag(name: "Coding", fontColor: "FD5B71")])
}
