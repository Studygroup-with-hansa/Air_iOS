//
//  UIViewPreview.swift.swift
//  Air_iOS
//
//  Created by 김부성 on 2021/09/27.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
extension UIView {
    private struct Preview: UIViewRepresentable {

        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
        }
    }

    func showPreview(width: CGFloat, height: CGFloat) -> some View {
        Preview(view: self).previewLayout(.fixed(width: width, height: height))
    }
}
#endif
