//
//  UIView++.swift
//  UIComponant
//
//  Created by Azizur Rahman on 3/8/22.
//

import Foundation
import UIKit

extension UIView{
    
    func maskByPath(path : UIBezierPath){
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = .evenOdd
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    func maskByImage(image : UIImage){
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        maskLayer.contents = [image]
        self.layer.mask = maskLayer
    }
    func centerRounded(centerRadius : CGFloat, cornerRadius : CGFloat = 0, cornerMask : [CACornerMask] = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner],_bounds : CGRect ){
        
        let mid = centerRadius / 2
        
        let centerPoint = CGPoint(x: _bounds.midX, y: _bounds.minY)
        let leftPoint = CGPoint(x: _bounds.midX - mid, y: _bounds.minY)
        
        let topLeftRadius = cornerMask.contains(.layerMinXMinYCorner) ? cornerRadius : 0
        let topRightRadius = cornerMask.contains(.layerMaxXMinYCorner) ? cornerRadius : 0
        let bottomLeftRadius = cornerMask.contains(.layerMinXMaxYCorner) ? cornerRadius : 0
        let bottomRightRadius = cornerMask.contains(.layerMaxXMaxYCorner) ? cornerRadius : 0
        
        let path = CGMutablePath()
        //line start from left mid
        path.move(to: CGPoint(x: _bounds.minX, y: _bounds.height / 2))
        //topLeft cornar radius
        path.addArc(tangent1End: CGPoint(x: _bounds.minX, y: _bounds.minY), tangent2End: leftPoint, radius: topLeftRadius)
        //center radius
        path.addArc(center: centerPoint, radius: centerRadius, startAngle: .pi, endAngle: 2 * .pi, clockwise: true)
        //top right radius
        path.addArc(tangent1End: CGPoint(x: _bounds.maxX, y: _bounds.minY), tangent2End: CGPoint(x: _bounds.maxX, y: _bounds.maxY), radius: topRightRadius)
        //bottom right radius
        path.addArc(tangent1End: CGPoint(x: _bounds.maxX, y: _bounds.maxY), tangent2End: CGPoint(x: _bounds.minX, y: _bounds.minY), radius: bottomRightRadius)
        //bottom left radius
        path.addArc(tangent1End: CGPoint(x: _bounds.minX, y: _bounds.maxY), tangent2End: CGPoint(x: _bounds.minX, y: _bounds.height / 2), radius: bottomLeftRadius)
        path.closeSubpath()
        //convert for visual
        //let beziarPath = UIBezierPath(cgPath: path)
        //for shadow on view
        
        shadowWithPath(path: path)
    }
    private func shadowWithPath(path : CGPath){
        let s = CAShapeLayer()
        let back = self.backgroundColor
        s.fillColor = (back != nil) ? back!.cgColor : UIColor.white.cgColor
        s.frame = layer.bounds
        s.path = path
        
        //its always clear
        layer.backgroundColor = UIColor.clear.cgColor
        //add mask layer
        layer.insertSublayer(s, at: 0)
        
        //for shadow
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowOpacity = 1.0
        layer.shadowPath = path
        layer.shadowRadius = 2
        
    }
    
    
    func setGradiantDashBoder(inset : CGFloat){
        let _bound = self.bounds.insetBy(dx: inset, dy: inset)
        let path = UIBezierPath(arcCenter: CGPoint(x: _bound.midX, y: _bound.midY), radius: _bound.width / 2, startAngle: -CGFloat.pi / 2.0, endAngle: (.pi *  3) / 2.0, clockwise: true)

        let outerPath = path //UIBezierPath( ovalIn: bounds.insetBy(dx: inset, dy: inset))
        let gradient = CAGradientLayer()
        if #available(iOS 12.0, *) {
            gradient.type = .conic
        } else {
            // Fallback on earlier versions
        }
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        gradient.colors = [ UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor,UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor,UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor,UIColor(red: 0, green: 0, blue: 0, alpha: 0.01).cgColor]

        let shapeMask = CAShapeLayer()
        shapeMask.path = outerPath.cgPath
        shapeMask.lineWidth = 8
        shapeMask.lineDashPhase = 4
        shapeMask.lineDashPattern = [ 0, 14 ]
        shapeMask.lineCap = .round
        shapeMask.lineJoin = .round
        shapeMask.strokeColor = UIColor.black.cgColor   //  Any color
        shapeMask.fillColor = nil
        gradient.mask = shapeMask
        layer.addSublayer( gradient )
    }
}
 //angle for cgpath
 //   ------3pi/2-----
 //pi ---------------- 2pi
 //   -------pi/2-----
