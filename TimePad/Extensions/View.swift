//
//  View.swift
//  TimePad
//
//  Created by Anday on 24.08.21.
//

import Foundation
import SwiftUI

extension View {
  func hud<Content: View>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) -> some View {
    ZStack(alignment: .top) {
      self

      if isPresented.wrappedValue {
        HUD(content: content)
          .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
              withAnimation {
                isPresented.wrappedValue = false
              }
            }
          }
          .zIndex(1)
      }
    }
  }
}
