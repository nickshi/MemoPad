//
//  MPColorPickerView.swift
//  MemoPad
//
//  Created by nick.shi on 3/11/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPColorPickerViewDelegate : class {
    func colorPickerView(_ colorPickerView: MPColorPickerView, selectedColor color: UIColor);
}

class MPColorPickerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate: MPColorPickerViewDelegate?;
    var circleView: UIView!;
    
    var lastLocation: CGPoint = CGPoint.zero;
    
    var currentPoint: CGPoint = CGPoint.zero {
        didSet {
            let point = CGPoint(x: max(0, min(self.frame.width, currentPoint.x)), y: max(0, min(self.frame.height, currentPoint.y)));
            circleView.center = point;
            let color = colorWithPoint(point: point);
            
            self.delegate?.colorPickerView(self, selectedColor: color);
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        circleView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30));
        circleView.layer.borderWidth = 1;
        circleView.layer.cornerRadius = 15;
        circleView.layer.borderColor = UIColor.white.cgColor;
        self.addSubview(circleView);
        
        let panGestureRecognize = UIPanGestureRecognizer(target: self, action: #selector(self.circleViewPan(gesture:)));
        circleView.gestureRecognizers = [panGestureRecognize];
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect);
        
        let context = UIGraphicsGetCurrentContext();
        let width: Int = Int(rect.size.width);
        let height: Int = Int(rect.size.height);
        for x in 0..<width {
            for y in 0..<height {
                let color = colorWithPoint(point: CGPoint(x: x, y: y));
                color.setFill();
                context!.fill(CGRect(x: x, y: y, width: 1, height: 1));
            }
        }
    }
    
    func circleViewPan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            lastLocation = circleView.center;
        } else if (gesture.state == .changed) {
            let moveXY = gesture.translation(in: self);
            let point = CGPoint(x: lastLocation.x + moveXY.x, y: lastLocation.y + moveXY.y);
            self.currentPoint = point;
        }
    }
    
    func colorWithPoint(point:CGPoint) -> UIColor{
        let hue = point.x / self.frame.width;
        let saturation = point.y / self.frame.height;
        
        return UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0);
    }

    

}
