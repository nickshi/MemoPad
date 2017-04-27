//
//  UIColor+RGB.swift
//  MemoPad
//
//  Created by nick.shi on 3/7/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

extension UIColor {
    public func red() ->CGFloat {
        var red: CGFloat = 0;
        self.getRed(&red, green: nil, blue: nil, alpha: nil);
        return red;
    }
    
    public func green() ->CGFloat {
        var green: CGFloat = 0;
        self.getRed(nil, green: &green, blue: nil, alpha: nil);
        return green;
    }
    
    public func blue() ->CGFloat {
        var blue: CGFloat = 0;
        self.getRed(nil, green: nil, blue: &blue, alpha: nil);
        return blue;
    }
    
    public func alpha() ->CGFloat {
        var alpha: CGFloat = 0;
        self.getRed(nil, green: nil, blue: nil, alpha: &alpha);
        return alpha;
    }
}
