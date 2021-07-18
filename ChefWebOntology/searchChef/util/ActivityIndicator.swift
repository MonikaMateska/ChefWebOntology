//
//  ActivityIndicator.swift
//  ChefWebOntology
//
//  Created by Monika Mateska on 18.7.21.
//

import SwiftUI

/// UIViewRepresentable implementation of AcitvityIndicatorView so that it can be used as a SwiftUI view.
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
