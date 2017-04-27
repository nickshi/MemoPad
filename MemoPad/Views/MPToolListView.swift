//
//  MPToolListView.swift
//  MemoPad
//
//  Created by nick.shi on 3/7/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPToolListViewDelegate {
    func toolListView(_ toolListView: MPToolListView, didPenSelected pen: Bool);
    func toolListView(_ toolListView: MPToolListView, didTextSelected text: Bool);
}
class MPToolListView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var btnBrush: UIButton!;
    var btnText: UIButton!;
    var collectionView: UICollectionView?;
    var delegate: MPToolListViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
       
        let size = 100;
        
        btnBrush = UIButton(type: .custom);
        btnBrush.frame = CGRect(x: 10, y: 10, width: size, height: size);
        btnBrush.setImage(#imageLiteral(resourceName: "Pencil Filled_100"), for: .normal);
        btnBrush.addTarget(self, action: #selector(self.btnBrushPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnBrush);
        
        btnText = UIButton(type: .custom);
        btnText.frame = CGRect(x: 110, y: 10, width: size, height: size);
        btnText.setImage(#imageLiteral(resourceName: "Text Box Filled_100"), for: .normal);
        btnText.addTarget(self, action: #selector(self.btnTextPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnText);

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnBrushPressed(sender: UIButton) {
        
        self.delegate?.toolListView(self, didPenSelected: true);
        self.removeFromSuperview();
    }
    
    func btnTextPressed(sender: UIButton) {
        
        self.delegate?.toolListView(self, didTextSelected: true);
        self.removeFromSuperview();
    }
    
    func show() {
        
    }
    
    func hide() {
        
    }

}
