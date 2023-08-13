//
//  esignButton.swift
//  ListTimer
//
//  Created by 宗野太郎 on 2023/08/13.
//

import SwiftUI

struct DesignButton: View {
    var body: some View {
        Text("hello")
            .font(.system(size: 20))
            .foregroundColor(.black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.ultraThinMaterial)
                    .shadow(color: .init(white: 0.5, opacity: 0.5), radius: 10, x: 0, y: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.init(white: 1, opacity:  0.6), lineWidth: 5)
            )
        
    }
}

struct DesignButton_Previews: PreviewProvider {
    static var previews: some View {
        DesignButton()
    }
}
