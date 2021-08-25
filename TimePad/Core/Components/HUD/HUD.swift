//
//  HUD.swift
//  TimePad
//
//  Created by Anday on 24.08.21.
//

import Foundation
import SwiftUI

struct HUD<Content: View>: View {
  @ViewBuilder let content: Content

  var body: some View {
    content
      .padding(.horizontal, 12)
      .padding(16)
      .background(
        Capsule()
          .foregroundColor(Color.white)
          .shadow(color: Color(.black).opacity(0.16), radius: 12, x: 0, y: 5)
      )
  }
}
