import SwiftUI
import AVFoundation

final class LoopingPlayerUIView: UIView {
	private var allURLs: [URL]
	private var player: AVQueuePlayer?
	private var token: NSKeyValueObservation?
	
	var playerLayer: AVPlayerLayer {
		return layer as! AVPlayerLayer
	}
	
	override class var layerClass: AnyClass {
		AVPlayerLayer.self
	}

	init(urls: [URL]) {
		allURLs = urls
		player = AVQueuePlayer()

		super.init(frame: .zero)
		addAllVideosToPlayer()
		
		playerLayer.player = player
		
		token = player?.observe(\.currentItem) { [weak self] player, _ in
			if player.items().count == 1 {
				self?.addAllVideosToPlayer()
			}
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addAllVideosToPlayer() {
		for url in allURLs {
			let asset = AVURLAsset(url: url)
			
			let item = AVPlayerItem(asset: asset)
			
			player?.insert(item, after: player?.items().last)
		}
	}
}

extension LoopingPlayerUIView {
	func setVolume(_ value: Float) {
		player?.volume = value
	}
	
	func setRate(_ value: Float) {
		player?.rate = value
	}
	
	func cleanup() {
		player?.pause()
		player?.removeAllItems()
		player = nil
	}
}

struct LoopingPlayerView: UIViewRepresentable {
	let videoURLs: [URL]
	
	@Binding var rate: Float
	@Binding var volume: Float
	
	func makeUIView(context: Context) -> LoopingPlayerUIView {
		let view = LoopingPlayerUIView(urls: videoURLs)
		
		view.setVolume(volume)
		view.setRate(rate)
		
		return view
	}
	
	func updateUIView(_ uiView: LoopingPlayerUIView, context: Context) {
		uiView.setVolume(volume)
		uiView.setRate(rate)
	}
	
	static func dismantleUIView(_ uiView: LoopingPlayerUIView, coordinator: ()) {
		uiView.cleanup()
	}
}
