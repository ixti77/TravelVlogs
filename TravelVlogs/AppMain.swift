import SwiftUI
import AVFoundation

@main
struct AppMain: App {
	
	init() {
		setVideoPlaybackCategory()
	}
	
  var body: some Scene {
    WindowGroup {
      VideoFeedView()
    }
  }
	
	private func setMixWithOthersPlaybackCategory() {
		try? AVAudioSession.sharedInstance().setCategory(
			AVAudioSession.Category.ambient,
			mode: AVAudioSession.Mode.moviePlayback,
			options: [.mixWithOthers]
		)
	}
	
	private func setVideoPlaybackCategory() {
		try? AVAudioSession.sharedInstance().setCategory(.playback)
	}
}
