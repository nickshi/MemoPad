//
//  MPTopConfirmView.swift
//  MemoPad
//
//  Created by nick.shi on 3/6/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPTopConfirmViewDelegate {
    func topConfirmViewOK(_ topConfirmView: MPTopConfirmView);
    func topConfirmViewCancel(_ topConfirmView: MPTopConfirmView);
}
class MPTopConfirmView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var btnCancel: UIButton!;
    var btnOK: UIButton!;
    
    var delegate: MPTopConfirmViewDelegate?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        let height:CGFloat = 35;
        let y = (frame.height - height) / 2;
        btnCancel = UIButton(type: .custom);
        btnCancel.frame = CGRect(x: frame.width - 50, y: y, width: height, height: height);
        btnCancel.setImage(#imageLiteral(resourceName: "Cancel"), for: .normal);
        btnCancel.setImage(#imageLiteral(resourceName: "Cancel Filled"), for: .highlighted);
        btnCancel.addTarget(self, action: #selector(self.btnCancelPressed(_:)), for: .touchUpInside);
        self.addSubview(btnCancel);
        
        btnOK = UIButton(type: .custom);
        btnOK.frame = CGRect(x: btnCancel.frame.origin.x - 50, y: y, width: height, height: height);
        btnOK.setImage(#imageLiteral(resourceName: "Ok"), for: .normal);
        btnOK.setImage(#imageLiteral(resourceName: "Ok Filled"), for: .highlighted);
        btnOK.addTarget(self, action: #selector(self.btnOKPressed(_:)), for: .touchUpInside);
        self.addSubview(btnOK);
        
        self.layer.borderWidth = 1;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func btnOKPressed(_ sender: UIButton) {
        self.delegate?.topConfirmViewOK(self);
    }
    
    func btnCancelPressed(_ sender: UIButton) {
        self.delegate?.topConfirmViewCancel(self);
    }
    
    func show() {
        UIView.animate(withDuration: 0.5, animations: {
            var frame = self.frame;
            frame.origin.y = 0;
            self.frame = frame;
        }) { (finished) in
            
        }

    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            var frame = self.frame;
            frame.origin.y = -frame.height;
            self.frame = frame;
        }) { (finished) in
            
        }
    }

}
