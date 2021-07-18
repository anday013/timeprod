//
//  ContentView.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: BottomBarRouter
    var body: some View {
        VStack{
            Spacer()
            switch viewRouter.currentPage {
            case .tasks:
                Tasks()
            case .add:
                Text("Add")
            case .stats:
                Text("Stats")
            
            }
            Spacer()
            BottomBarView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BottomBarRouter())
    }
}
