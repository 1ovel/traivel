//
//  CircleButton.swift
//  Traivel
//
//  Created by Daria on 19.6.2024.
//

import SwiftUI

struct CircleButton: View {
    let size: ButtonSize
    let image: String
    let action: () -> Void
    
    func getButtonSize(size: ButtonSize) -> CGFloat {
        switch size {
        case .small:
            return 35
        case .medium:
            return 50
        }
    }
    
    enum ButtonSize {
        case small
        case medium
    }
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .frame(width: getButtonSize(size: size), height: getButtonSize(size: size))
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    func test() {
        
    }
    return CircleButton(size: .medium, image: "chevron.up", action: test)
}
