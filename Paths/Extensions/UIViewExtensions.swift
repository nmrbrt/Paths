//
//  UIViewExtensions.swift
//  Paths
//
//  Created by Bratt Neumayer on 6/23/18.
//  Copyright © 2018 Bratt Neumayer. All rights reserved.
//

import Foundation
import UIKit

enum CornerSize{
    case small, medium, large
}

extension UIView{
    
    func setCorners(to: CGFloat){
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5//self.foodBackgroundView.bounds.height / 2
        self.layer.masksToBounds = true
        
    }
    
    
    func makeRoundWithBorder(){
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.bounds.height / 2.0
        self.layer.masksToBounds = true
    }
    
    func makeRoundWithLightGreyBorder(){
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
    
    func makeCircleNoBorder(){
        
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
    
    
    func makeSquareWithCorner(size: CornerSize, borderWidth: CGFloat){
        
        self.layer.masksToBounds = true
        
        
        switch borderWidth {
        case 0:
            break
        default:
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = borderWidth
        }
        
        switch size {
        case .small:
            self.layer.cornerRadius = 5
        case .medium:
            self.layer.cornerRadius = 10
        default:
            self.layer.cornerRadius = 15
        }
    }
    
    
    func makeSquareWithCorner(size: CornerSize, borderWidth: CGFloat, color: UIColor){
        
        self.layer.masksToBounds = true
        
        
        switch borderWidth {
        case 0:
            break
        default:
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = borderWidth
        }
        
        switch size {
        case .small:
            self.layer.cornerRadius = 5
        case .medium:
            self.layer.cornerRadius = 10
        default:
            self.layer.cornerRadius = 15
        }
    }
    
    
    func makeSquareWithCorner(size: CGFloat, borderWidth: CGFloat){
        
        self.layer.masksToBounds = true
        
        
        switch borderWidth {
        case 0:
            break
        default:
            self.layer.borderColor = UIColor.darkGray.cgColor
            self.layer.borderWidth = borderWidth
        }
        
        self.layer.cornerRadius = size
    }
    
    
    
    func dropShadow(scale: Bool = true) {
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 7
    }
    
    func dropThinShadow() {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
    
    
    func dropShadowForText(scale: Bool = true) {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
    
    func dropShadow(withRadius radius: CGFloat) {
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.cornerRadius = 10
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 2
    }
    
    
    
}

