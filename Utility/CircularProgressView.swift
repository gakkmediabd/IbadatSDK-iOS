//
//  CircularProgressView.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 4/8/22.
//

import UIKit

class CircularProgressView: UIView {

    fileprivate var progressLayer = CAShapeLayer()
    var progress : CGFloat = 0{
        didSet{
            setProgress(to: Float(progress))
        }
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setGradiantDashBoder(inset: 8)
        progressLayerSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setGradiantDashBoder(inset: 8.0)
        progressLayerSetup()
    }


    fileprivate func progressLayerSetup(){
        //stroke start depend on path.
        //path start point is stroke start point
        let _bound = self.bounds.insetBy(dx: 8, dy: 8)
        let path = UIBezierPath(arcCenter: CGPoint(x: _bound.midX, y: _bound.midY), radius: _bound.width / 2, startAngle: -CGFloat.pi / 2.0, endAngle: (.pi *  3) / 2.0, clockwise: true)


        progressLayer.path = path.cgPath
        progressLayer.lineWidth = 8
        //progressLayer.lineCap = .round
        //progressLayer.lineJoin = .round
        progressLayer.fillColor = .none
        progressLayer.strokeColor = UIColor.tintColor.cgColor

        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.1
        
        layer.addSublayer(progressLayer)
    }
    func setProgress(duration: TimeInterval = 0.3, to newProgress: Float) -> Void{
        progressLayer.strokeEnd = progress
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.duration = duration
//        animation.fromValue = 0
//        animation.toValue = progress
//        animation.autoreverses = false
//        animation.repeatCount = .nan
//        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false
//        progressLayer.add(animation, forKey: "line")
        
        
    }

}
