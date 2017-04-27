//
//  MPSketchView+TouchEvent.swift
//  MemoPad
//
//  Created by nick.shi on 3/1/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

extension MPSketchView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count != 0 else {
            print("NO touches");
            return;
        }
        
        let touchPoint = touches.first!.preciseLocation(in: self);
        
        if self.currentTool == .pencil || self.currentTool == .eraser || self.currentTool == .smartPencil {
            self.pointsBuffer.append(touchPoint);
            self.updateTopLayer();
            self.setNeedsDisplay();
        } else if self.currentTool == .reactange {
            self.rectBeginPoint = touchPoint;
        } else {
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count != 0 else {
            print("NO touches");
            return;
        }
        
        let touchPoint = touches.first!.preciseLocation(in: self);
        
        if self.currentTool == .pencil || self.currentTool == .eraser || self.currentTool == .smartPencil {
            self.pointsBuffer.append(touchPoint);
            self.updateTopLayer();
            self.setNeedsDisplay();
        } else if self.currentTool == .reactange {
            self.rectEndPoint = touchPoint;
            self.updateTopLayer();
        } else {
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard touches.count != 0 else {
            print("NO touches");
            return;
        }
        
        let touchPoint = touches.first!.preciseLocation(in: self);
        
        if self.currentTool == .pencil || self.currentTool == .eraser || self.currentTool == .smartPencil {
            self.pointsBuffer.append(touchPoint);

        } else if self.currentTool == .reactange {
            self.rectEndPoint = touchPoint;
            
        } else {
            
        }

        if self.currentTool == .pencil ||
            self.currentTool == .eraser ||
            self.currentTool == .smartPencil ||
            self.currentTool == .reactange{
            let finalColor = self.currentTool == .eraser ? self.eraserColor : self.currentColor;
            
            let path = self.buildBezierPath();
            self.addShapeLayer(path, lineWidth: self.currentLineWidth, color: finalColor);
            self.delegate?.sketchViewUpdateUndoRedoState(self);
            self.pointsBuffer.removeAll();
            self.clearTopLayer();
            self.setNeedsDisplay();
        }

    }
    
    func buildBezierPath() -> UIBezierPath {
        if self.currentTool == .pencil || self.currentTool == .eraser || self.currentTool == .smartPencil {
            let path = MPBezierPath(withPoints: self.pointsBuffer);
            let smoothPath = path.soothPath(20);
            return smoothPath;
            
            
        }else if self.currentTool == .reactange {
            let minX = min(rectBeginPoint.x, rectEndPoint.x);
            let minY = min(rectBeginPoint.y, rectEndPoint.y);
            
            let width = abs(rectEndPoint.x - rectBeginPoint.x);
            let height = abs(rectEndPoint.y - rectBeginPoint.y);
            let path = UIBezierPath(roundedRect: CGRect(x: minX, y: minY, width: width, height: height), cornerRadius: 2);
            return path;
        } else {
            return UIBezierPath();
        }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.currentTool == .pencil || self.currentTool == .eraser || self.currentTool == .smartPencil {
            self.pointsBuffer.removeAll();
        }
    }

}
