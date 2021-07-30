//
//  CircularMinutePickerView.swift
//  TimePad
//
//  Created by Anday on 29.07.21.
//

import SwiftUI

struct CircularMinutePickerView: View {
    @Binding var minutes: Int
    @State private var localMinutes: Int
    @State var showPicker: Bool = false
    
    init(minutes: Binding<Int>) {
        self._minutes = minutes
        self.localMinutes = minutes.wrappedValue
        print("self.localMinutes: \(self.localMinutes)")
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text("Minutes")
                    .font(.title3)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(localMinutes)")
                    .font(.title2)
                    .foregroundColor(Color.theme.gradientPurple)
                
                
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
            }
            .padding()
            .background(Color.theme.accent.cornerRadius(12))
            .onTapGesture {
                showPicker.toggle()
            }
           
            
            if showPicker {
                CircularPicker(minutes: $localMinutes, onEnd: self.onEnd)
                    .frame(width: 300, height: 300, alignment: .center)
                    .background(Color.primary.cornerRadius(8))
            }
        }
    }
    
    func onEnd() {
        self.minutes = self.localMinutes
        self.showPicker.toggle()
    }
}

struct CircularPicker: View {
    @Binding var minutes: Int
    @State private var angle: Double = 0
    var onEnd: () -> Void
    
    init(minutes: Binding<Int>, onEnd: @escaping () -> Void) {
        self._minutes = minutes
        self.onEnd = onEnd
    }
    var body: some View {
        GeometryReader { reader in
            ZStack{
                let width = reader.frame(in: .global).width / 2
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .offset(x: width - 50)
                    .rotationEffect(.init(degrees: angle))
                    .gesture(DragGesture().onChanged(onDragChange(value:)).onEnded(onDragEnd(value:)))
                    .rotationEffect(.init(degrees: -90))
                
                
                
                ForEach(1...12, id: \.self) { index in
                    VStack {
                        Text("\(index == 12 ? 0 : index * 5)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .rotationEffect(.init(degrees: Double(-index) * 30))
                    }
                    .offset(y: -width + 50)
                    .rotationEffect(.init(degrees: Double(index) * 30))
                }
                
                
                // Arrow
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .overlay (
                        
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 2, height: width / 2)
                        ,alignment: .bottom
                        
                    )
                    .rotationEffect(.init(degrees: angle))
                    .onAppear {
                        self.angle = Double(minutes * 6)
                        print("self.angle: \(self.angle)")
                    }
                    
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }.frame(height: 300)
    }
    
    func onDragChange(value: DragGesture.Value) {
        
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radians = atan2(vector.dy - 20, vector.dx - 20)
        
        var angle = radians * 180 / .pi
        
        if angle < 0 {angle += 360}
        
        self.angle = Double(angle)
        let progress =  self.angle / 360
        self.minutes = Int(progress * 60) == 60 ? 0 : Int(progress * 60)
        
    }
    
    func onDragEnd(value: DragGesture.Value) {
        self.onEnd()
    }
    
}

struct CircularMinutePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CircularMinutePickerView(minutes: .constant(0))
            .previewLayout(.sizeThatFits)
        
        CircularMinutePickerView(minutes: .constant(0))
            .previewLayout(.sizeThatFits)
            .padding()
            .preferredColorScheme(.dark)
    }
}
