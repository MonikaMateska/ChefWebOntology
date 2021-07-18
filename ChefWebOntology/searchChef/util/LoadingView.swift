//
//  LoadingView.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 18.7.21.
//

import SwiftUI

/// View displayed when something is loading.
struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var text: String? = nil
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                    if let text = text {
                        Text(text)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.black)
                    }
                }
                .frame(width: geometry.size.width / 3,
                       height: geometry.size.height / 6)
                .background(Color.secondary.colorInvert())
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

}
