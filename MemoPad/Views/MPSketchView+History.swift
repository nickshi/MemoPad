//
//  MPSketchView+History.swift
//  MemoPad
//
//  Created by nick.shi on 3/4/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

extension MPSketchView {
    public func undo() {
        let recentLayer = self.mostRecentLayer();
        
        if recentLayer !=  nil {
            self.history.append(recentLayer!);
            recentLayer!.removeFromSuperlayer();
            self.currents.removeLast();
            self.delegate?.sketchViewUpdateUndoRedoState(self);
        }
    }
    
    public func redo() {
        let recentUndoLayer = self.history.last;
        
        if recentUndoLayer != nil {
            self.layer.insertSublayer(recentUndoLayer!, below: self.topLayer);
            self.currents.append(recentUndoLayer!);
            self.history.removeLast();
            self.delegate?.sketchViewUpdateUndoRedoState(self);
        }
    }
    
    public func flushAllHistory() {
        self.history.removeAll();
    }
    
}
