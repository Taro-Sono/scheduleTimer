//
//  ListTimerTop.swift
//  ListTimer
//
//  Created by 宗野太郎 on 2023/08/13.
//

import SwiftUI

struct ListTimerTop: View {
    @State private var isChange = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Schedule Timer")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                
                
                Spacer()
                    .frame(height: 300)
                
                
                
                Button {
                    isChange.toggle()
                } label: {
                    ZStack {
                        Image(systemName: "oval.inset.filled")
                            .resizable()
                            .frame(width: 200, height: 100)
                            .foregroundColor(.black)
                        
                        Text("Study")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationDestination(isPresented: $isChange, destination:{ ContentView()})
        }
    }
}

struct ListTimerTop_Previews: PreviewProvider {
    static var previews: some View {
        ListTimerTop()
    }
}
