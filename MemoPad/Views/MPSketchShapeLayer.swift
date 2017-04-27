//
//  MPSketchShapeLayer.swift
//  MemoPad
//
//  Created by nick.shi on 2/28/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

class MPSketchShapeLayer: CAShapeLayer {
    override init() {
        super.init();
        configureLayer();
    }
    
    override init(layer: Any) {
        super.init(layer: layer);
        configureLayer();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayer() {
        
    }
}
