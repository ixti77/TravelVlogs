import SwiftUI

struct ErrorView: View {
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    VStack {
      Text("What do you think could go wrong? 🤔")
        .font(.title3)
        .padding()
      Button {
        presentationMode.wrappedValue.dismiss()
      }
      label: {
        Text("Dismiss")
          .font(.title3)
          .bold()
      }
    }
  }
}

struct ErrorView_Previews: PreviewProvider {
  static var previews: some View {
    ErrorView()
  }
}
