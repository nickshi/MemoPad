//
//  MPOperationBarView.swift
//  MemoPad
//
//  Created by nick.shi on 3/4/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPOperationBarViewDelegate {
    func operationBarView(operationBarView: MPOperationBarView, undo:Bool);
    func operationBarView(operationBarView: MPOperationBarView, redo:Bool);
    func operationBarView(operationBarView: MPOperationBarView, share:Bool);
}
class MPOperationBarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: MPOperationBarViewDelegate?;
    var btnUndo: UIButton!;
    var btnRedo: UIButton!;
    var btnShare: UIButton!;
  
    public var canUndo: Bool = false {
        didSet {
            btnUndo.isEnabled = canUndo;
        }
    }
    
    public var canRedo: Bool = false {
        didSet {
            btnRedo.isEnabled = canRedo;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);

        let height: CGFloat = 40;
        let y = (frame.height - height)/2;
        btnUndo = UIButton(type: .custom);
        btnUndo.frame = CGRect(x: 0, y: y, width: height, height: height);
        btnUndo.setImage(#imageLiteral(resourceName: "Undo"), for: .normal);
        btnUndo.addTarget(self, action: #selector(self.btnUndoPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnUndo);
        //btnUndo.isEnabled = false;
        
        btnRedo = UIButton(type: .custom);
        btnRedo.frame = CGRect(x: 50, y: y, width: height, height: height);
        btnRedo.setImage(#imageLiteral(resourceName: "Redo"), for: .normal);
        btnRedo.addTarget(self, action: #selector(self.btnRedoPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnRedo);
        
        
        btnShare = UIButton(type: .custom);
        btnShare.frame = CGRect(x: 200, y: y, width: height, height: height);
        btnShare.setImage(#imageLiteral(resourceName: "Download-100"), for: .normal);
        btnShare.addTarget(self, action: #selector(self.btnSharePressed(sender:)), for: .touchUpInside);
        self.addSubview(btnShare);
        //btnRedo.isEnabled = false;

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnUndoPressed(sender: UIButton) {
        delegate?.operationBarView(operationBarView: self, undo: true);
    }
    
    func btnRedoPressed(sender: UIButton) {
        delegate?.operationBarView(operationBarView: self, redo: true);
    }
    
    func btnSharePressed(sender: UIButton) {
        delegate?.operationBarView(operationBarView: self, share: true);
    }
}
