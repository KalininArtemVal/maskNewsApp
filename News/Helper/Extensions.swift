//
//  Extensions.swift
//  News
//
//  Created by Калинин Артем Валериевич on 23.04.2021.
//

import UIKit

// MARK: - UIView
extension UIView {
    
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
