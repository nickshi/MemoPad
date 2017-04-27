//
//  MPSketchView+Layers.swift
//  MemoPad
//
//  Created by nick.shi on 3/1/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

extension MPSketchView {
    
    func addShapeLayer(_ shape: UIBezierPath, lineWidth: CGFloat, color: UIColor) {
        let newLayer = MPSketchShapeLayer();
        
        newLayer.path = shape.cgPath;
        newLayer.lineWidth = lineWidth;
        newLayer.lineCap = "round";
        newLayer.strokeColor = color.cgColor;
        newLayer.fillColor = UIColor.clear.cgColor;
        newLayer.contentsScale = UIScreen.main.scale;
        self.layer.insertSublayer(newLayer, below: self.topLayer);
        self.currents.append(newLayer);
        newLayer.setNeedsDisplay();
        self.flushAllHistory();
    }
    
    
    func addTextLayer(_ layer: CALayer, position: CGPoint) {
        self.layer.insertSublayer(layer, below: self.topLayer);
        layer.position = position;
        self.currents.append(layer);
        self.delegate?.sketchViewUpdateUndoRedoState(self);
    }
    
    func mostRecentLayer() ->CALayer? {
        return currents.last;
    }
    
    func shapeLayerCount() -> Int {
        return currents.count;
    }
    
    func updateTopLayer() {
        
        self.topLayer.lineWidth = self.currentLineWidth;
        self.topLayer.lineCap = "round";
        let strokeColor = (self.currentTool == .eraser ? self.eraserColor : self.currentColor);
        self.topLayer.strokeColor = strokeColor.cgColor;
        self.topLayer.fillColor = UIColor.clear.cgColor;
        self.topLayer.contentsScale = UIScreen.main.scale;
        
        let path = buildBezierPath();
        self.topLayer.path = path.cgPath;

    }
    
    func clearAllLayers() {
        for layer in currents {
            layer.removeFromSuperlayer();
        }
        self.currents.removeAll();
        clearTopLayer();
    }
    
    func clearTopLayer() {
         self.topLayer.path = nil;
    }
}
