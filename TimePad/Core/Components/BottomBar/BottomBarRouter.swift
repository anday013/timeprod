//
//  BottomTabRouter.swift
//  TimePad
//
//  Created by Anday on 11.07.21.
//

import Foundation

enum Page {
    case tasks
    case add
    case stats
}


class BottomBarRouter: ObservableObject {
    @Published var currentPage: Page = .tasks
    
}
