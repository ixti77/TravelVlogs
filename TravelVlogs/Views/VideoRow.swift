import SwiftUI

struct VideoRow: View {
  let video: Video

  private let imageHeight: CGFloat = 250
  private let imageCornerRadius: CGFloat = 12.0

  var body: some View {
    VStack(alignment: .leading) {
      Text(video.title)
        .font(.title2)

      GeometryReader { proxy in
        Image("\(video.fileName)")
          .resizable()
          .scaledToFill()
          .frame(width: proxy.size.width, height: imageHeight)
          .clipShape(
            RoundedRectangle(
              cornerRadius: imageCornerRadius,
              style: .continuous))
          .shadow(radius: imageCornerRadius / 3.0)
      }
      .frame(height: imageHeight)

      Text(video.subtitle)
        .font(.subheadline)
    }
    .padding(.vertical)
  }
}

struct VideoRow_Previews: PreviewProvider {
  static var previews: some View {
    VideoRow(video: Video.fetchLocalVideos()[0])
  }
}
