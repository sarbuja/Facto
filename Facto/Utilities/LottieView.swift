import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {

    let lottieFile: String
    let mode: LottieLoopMode
    let action: (() -> Void)?
    let animationView = LottieAnimationView()

    init(lottieFile: String,
         mode: LottieLoopMode = .loop,
         action: (() -> Void)? = nil) {
        self.lottieFile = lottieFile
        self.mode = mode
        self.action = action
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        animationView.animation = LottieAnimation.named(lottieFile)
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

    }
}
