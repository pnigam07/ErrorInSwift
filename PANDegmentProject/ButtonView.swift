//
//  ButtonView.swift
//  PANDegmentProject
//
//  Created by pankaj nigam on 7/15/25.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    print("hello world")
                    // Refresh action can be handled by parent if needed
                }
            }) {
                HStack() {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 16))
                        .padding(.trailing, 14)
                    Text("Refresh")
                        .font(.caption)
                }
               // .font(.body)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .padding(4)
                .background(Color.red)
                .cornerRadius(16)
                .frame(height: 50 )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.blue, lineWidth: 1)
                )
            }
        }
    }
}

#Preview {
    ButtonView()
}
