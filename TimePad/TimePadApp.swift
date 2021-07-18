//
//  TimePadApp.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import SwiftUI

@main
struct TimePadApp: App {
    @StateObject var viewRouter:BottomBarRouter = BottomBarRouter()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                
        }
    }
}
