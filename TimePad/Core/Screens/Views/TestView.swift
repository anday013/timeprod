//
//  TestView.swift
//  TimePad
//
//  Created by Anday on 17.07.21.
//

import SwiftUI

struct TestView: View {
    @State var isPresented: Bool = false
    var body: some View {
        VStack {
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text("Toggle")
                    .bold()
                    .frame(width: 250, height: 70)
                    .background(Color.yellow.cornerRadius(30))
                    .font(.title)
                    .foregroundColor(.black)
                    
                    
            })
        }
        .sheet(isPresented: $isPresented, content: {
            TestComponentView {
                Text("YES")
            }
        })
    }
}


struct TestComponentView<Content: View>: View {
    var content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "E9E9FF"))
                .frame(width: 40, height: 4)
                .padding()
            Spacer()
            content()
            Spacer()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
