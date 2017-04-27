//
//  MPDrawView.swift
//  MemoPad
//
//  Created by nick.shi on 2/28/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPSketchViewDelegate {
    func sketchViewUpdateUndoRedoState(_ sketchView: MPSketchView);
}

public enum Tools: Int {
    case all = -1
    case finger
    case pencil
    case smartPencil
    case eraser
    case reactange
    case text
}

class MPSketchView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: MPSketchViewDelegate?;
    

    
    public var currentTool: Tools = .pencil;
    
    public var currentLineWidth: CGFloat = 10.0;
    
    public var currentColor: UIColor = UIColor.black;
    
    var eraserColor: UIColor {
        get {
            return self.backgroundColor != nil ? self.backgroundColor! : UIColor.white;
        }
    }
    
    var currents = [CALayer]();
    var history = [CALayer]();
    public var maxUndoRedoSteps = 10;
    
    var topLayer: MPSketchTopShapeLayer!;
    
    var pointsBuffer = [CGPoint]();
    
    var rectBeginPoint: CGPoint = CGPoint.zero;
    
    var rectEndPoint: CGPoint = CGPoint.zero;
    
    public var canUndo: Bool {
        get {
            return currents.count > 0;
        }
    }
    
    public var canRedo: Bool {
        get {
            return self.history.count > 0;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configureView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        configureView();
    }
    
    func configureView() {
        //self.layer.borderWidth = 1;
        self.backgroundColor = UIColor.white;
        
        self.topLayer = MPSketchTopShapeLayer();
        self.topLayer.fillColor = nil;
        self.layer.addSublayer(self.topLayer);
    }
    
    func produceImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!;
    }

}
