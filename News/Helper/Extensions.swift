//
//  Extensions.swift
//  News
//
//  Created by Калинин Артем Валериевич on 23.04.2021.
//

import UIKit

// MARK: - Int
extension Int {

    private var iPhoneXSize: (width: CGFloat, height: CGFloat) { (375, 812) }
    private var screenSize: CGSize { UIScreen.main.bounds.size }
    
    /// Используется для увеличения различных размеров (шрифтов, высот и ширин).
    var fit: CGFloat {
        var ratio: CGFloat = 1
        // Если девайс более новый, чем iPhoneX, и его высота экрана больше, то  можно всё увеличивать пропорционально высоте экрана. Если это старые девайсы, у которых экран по высоте меньше, то можно оставить размер, как он есть.
        if screenSize.height > iPhoneXSize.height {
            ratio = screenSize.height / iPhoneXSize.height
        }
        return CGFloat(self) * ratio
    }
    
    /// Используется для подгонки вертикальных констрейнтов.
    var fitY: CGFloat {
        var ratio: CGFloat = 1
        if screenSize.height >= iPhoneXSize.height {
            ratio = screenSize.height / iPhoneXSize.height
        } else {
            // Констрейнты лейблов привязаны к низу экрана. Для старых девайсов нужно спускать надписи сильнее, чем поднимать для новых, поэтому добавлен коэффициент 1.15, взятый на глаз. Картинки у старых девайсов пропорционально больше, чем у новых девайсов с узкими типоразмерами экранов, и без этого коэффициента они почти слипаются с лейблами.
            ratio = screenSize.height / iPhoneXSize.height / 1.15
        }
        return CGFloat(self) * ratio
    }
    
    /// Используется для подгонки горизонтальных констрейнтов.
    var fitX: CGFloat {
        var ratio: CGFloat = 1
        ratio = screenSize.width / iPhoneXSize.width
        return CGFloat(self) * ratio
    }
    
}

// MARK: - FloatingPoint
extension FloatingPoint {
    var isInt: Bool {
        return floor(self) == self
    }
}

// MARK: - Device
extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension UIDevice {
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }

    enum ScreenType: String {
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXSMax
        case iPhone11
        case iPhone11Pro
        case iPhoneSE
        case iPhone12
        case iPhone12Pro
        case iPhone12Mini
        case Unknown
    }

    var screenType: ScreenType {
        guard iPhone else { return .Unknown}
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhoneSE
        case 1334:
            return .iPhone8
        case 2208:
            return .iPhone8Plus
        case 2436:
            return .iPhoneX
        case 2521:
            return .iPhone12
        case 2532:
            return .iPhone11Pro
        case 2688:
            return .iPhoneXSMax
        case 2778:
            return .iPhone12Pro
        case 1792:
            return .iPhone11
        default:
            return .Unknown
        }
    }

}

// MARK: - UIView
extension UIView {
    
    func stretchFullOn(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Stretches itself to the size of the view except for the Safe Area
    func stretchFullSafelyOn(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    /// Apply Gradient to View (or button, or something else) with COLOR and START/END Point
    func applyGradientWithStartAndEndPoint(colors: [UIColor], cornerRadius: CGFloat? = nil, isTopToBottom: Bool = false, startTopPoint: CGPoint, endTopPoint: CGPoint, startBottomPoint: CGPoint, endBottomPoint: CGPoint) {
        if let _ = layer.sublayers?.first as? CAGradientLayer {
            layer.sublayers?.first?.removeFromSuperlayer()
        }
            
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }

        if isTopToBottom {
            gradientLayer.startPoint = startTopPoint
            gradientLayer.endPoint = endTopPoint
        } else {
            gradientLayer.startPoint = startBottomPoint
            gradientLayer.endPoint = endBottomPoint
        }
        
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius ?? 0
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

// MARK: - UICollectionViewCell
extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 16
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 1.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}

// MARK: - UIImage
extension UIImage {
    func resizedImage(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
}
