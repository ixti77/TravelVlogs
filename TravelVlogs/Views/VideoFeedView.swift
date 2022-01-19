import SwiftUI
import AVKit

struct VideoFeedView: View {
	@State private var selectedVideo: Video?
	@State private var embeddedVideoRate: Float = 0.0
	@State private var embeddedVideoVolume: Float = 0.0
	
	private let videos = Video.fetchLocalVideos() + Video.fetchRemoteVideos()
	private let videoClips = VideoClip.urls

  var body: some View {
    NavigationView {
      List {
        makeEmbeddedVideoPlayer()
        ForEach(videos) { video in
          Button {
            selectedVideo = video
          } label: {
            VideoRow(video: video)
          }
        }
      }
      .navigationTitle("Travel Vlogs")
    }
		.fullScreenCover(item: $selectedVideo) {
			embeddedVideoRate = 1.0
		} content: { item in
			makeFullScreenVideoPlayer(for: item)
		}
  }

  private func makeEmbeddedVideoPlayer() -> some View {
    HStack {
      Spacer()

      LoopingPlayerView(
				videoURLs: videoClips,
				rate: $embeddedVideoRate,
				volume: $embeddedVideoVolume
			)
        .background(Color.black)
        .frame(width: 250, height: 140)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(.vertical)
				.onAppear {
					embeddedVideoRate = 1
				}
				.onTapGesture(count: 2) {
					embeddedVideoRate = embeddedVideoRate == 1.0 ? 2.0 : 1.0
				}
				.onTapGesture {
					embeddedVideoVolume = embeddedVideoVolume == 1.0 ? 0.0 : 1.0
				}

      Spacer()
    }
  }
	
	@ViewBuilder
	private func makeFullScreenVideoPlayer(for video: Video) -> some View {
		if let url = video.videoURL {
			let avPlayer = AVPlayer(url: url)
			VideoPlayerView(player: avPlayer)
				.edgesIgnoringSafeArea(.all)
				.onAppear {
					embeddedVideoRate = 0.0
					avPlayer.play()
				}
		} else {
			ErrorView()
		}
	}
}

struct VideoFeedView_Previews: PreviewProvider {
  static var previews: some View {
    VideoFeedView()
  }
}
