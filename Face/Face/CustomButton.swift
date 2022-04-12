
import Foundation
import SwiftUI

struct CustomButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(20)
          .padding(.horizontal)
  }
}


