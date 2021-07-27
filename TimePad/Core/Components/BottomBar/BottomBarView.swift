//
//  BottomBarView.swift
//  TimePad
//
//  Created by Anday on 07.07.21.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var viewRouter: BottomBarRouter
    private let iconSize = Size.computeWidth(28)
    private let plusSize = Size.computeWidth(24)
    private let plusCircleSize = Size.computeWidth(44)
    var body: some View {
        VStack {
            HStack {
                BarIcon(name: "tasks_icon", size: iconSize)
                    .foregroundColor(viewRouter.currentPage == .tasks ? .primary : .gray)
                    .onTapGesture {
                        viewRouter.currentPage = .tasks
                    }
                
                Spacer()
                
                BarIcon(name: "plus_icon", size: plusSize)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .background(
                       plusCircle
                    )
                    .onTapGesture {
                        viewRouter.currentPage = .add
                    }
                
                Spacer()
                
                BarIcon(name: "stats_icon", size: iconSize)
                    .foregroundColor(viewRouter.currentPage == .stats ? .primary : .gray)
                    .onTapGesture {
                        viewRouter.currentPage = .stats
                    }
                
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.79, height: UIScreen.main.bounds.height / 8 )
            
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(BottomBarRouter())
        
        BottomBarView()
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(BottomBarRouter())
            .preferredColorScheme(.dark)
    }
}


struct BarIcon: View {
    var name: String
    var size: CGFloat
    var body: some View {
        Image(name)
            .resizable()
            .frame(width: size, height: size)
        
    }
}

extension BottomBarView {
    private var plusCircle: some View {
        Circle()
            .fill()
            .frame(width: plusCircleSize, height: plusCircleSize)
    }
}
