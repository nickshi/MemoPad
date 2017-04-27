//
//  MPBezierPath.swift
//  MemoPad
//
//  Created by nick.shi on 2/28/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//
//The algorithm comes from http://stackoverflow.com/questions/8702696/drawing-smooth-curves-methods-needed

import UIKit

class MPBezierPath: UIBezierPath {
    
    var points = [CGPoint]();
    
    convenience init(withPoints points: [CGPoint]) {
        self.init();
        self.points = points;
    }
    
    func soothPath(_ granularity: Int) -> UIBezierPath {
        var points = self.points;
        
        if (points.count < 4) {
            let newPath = UIBezierPath();
            
            if points.count > 0 {
                for index in 0...points.count - 1 {
                    if index == 0 {
                        newPath.move(to: points[index]);
                        if points.count == 1 {
                            newPath.addLine(to: points[index]);
                        }
                    } else {
                        newPath.addLine(to: points[index]);
                    }
                }
            }
            
            return newPath;
        }
        
        points.insert(points[0], at: 0);
        points.append(points.last!);
        
        let newPath = UIBezierPath();
        newPath.removeAllPoints();
        
        newPath.move(to: points[0]);

        for index in 1...points.count - 3 {
            let p0 = points[index - 1];
            let p1 = points[index];
            let p2 = points[index + 1];
            let p3 = points[index + 2];
            
            for i in 1...granularity-1 {
                let t = CGFloat(i) * (1.0 / CGFloat(granularity));
                let tt = t * t;
                let ttt = tt * t;
                
                var pi: CGPoint = CGPoint();
                
//                let xt = (p2.x - p0.x) * t;
//                let xtt = (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * tt;
                
                pi.x = 0.5 * (2*p1.x+(p2.x-p0.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x)*tt + (3*p1.x-p0.x-3*p2.x+p3.x)*ttt);
                pi.y = 0.5 * (2*p1.y+(p2.y-p0.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y)*tt + (3*p1.y-p0.y-3*p2.y+p3.y)*ttt);
                newPath.addLine(to: pi);
            }
            newPath.addLine(to: p2);
        }
        
        newPath.addLine(to: points.last!);
        
        return newPath;
    }
 
}
