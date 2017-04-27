//
//  ColorPlateView.swift
//  MemoPad
//
//  Created by nick.shi on 2/20/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

public enum PlateType {
    case color
    case add
}

class MPColorPlateView: UICollectionViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var imageView: UIImageView!;
    var plateType: PlateType = .color {
        didSet {
            imageView.isHidden = plateType == .color;
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.red;
        self.layer.cornerRadius = frame.width / 2;
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColor.gray.cgColor;
        
        imageView = UIImageView(image: #imageLiteral(resourceName: "Plus-100"));
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
        imageView.center = CGPoint(x: frame.width / 2, y: frame.height / 2);
        self.addSubview(imageView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func plateView(color: UIColor) ->MPColorPlateView {
        let plateView = MPColorPlateView(frame: CGRect(x:0, y:0, width:50, height:50));
        plateView.backgroundColor = color;
        return plateView;
    }

}
