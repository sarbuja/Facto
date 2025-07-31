import SwiftUI
import RswiftResources
import Lottie

struct LottieView: UIViewRepresentable {

    let lottieFile: String
    let mode: LottieLoopMode
    let action: (() -> Void)?
    let animationView = LottieAnimationView()

    init?(resource: FileResource,
         mode: LottieLoopMode = .loop,
         action: (() -> Void)? = nil) {
        guard let url = resource.url() else {
            return nil
        }
        self.lottieFile = url.path
        self.mode = mode
        self.action = action
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        animationView.animation = LottieAnimation.filepath(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = mode
        animationView.play { _ in
            animationView.stop()
            action?()
        }
        view.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // NOT APPLICABLE
    }
}
