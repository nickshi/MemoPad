//
//  MPDraggableView.swift
//  MemoPad
//
//  Created by nick.shi on 3/4/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit
protocol MPDraggableTextViewDelegate {
    func draggableTextViewDidEndEditing(_ textView: MPDraggableTextView);
    func draggableTextViewDidBeginEditing(_ textView: MPDraggableTextView);
}
class MPDraggableTextView: UIView, UITextViewDelegate {
    var lastLocation: CGPoint = CGPoint.zero;
    var lastChulkLocation: CGPoint = CGPoint.zero;
    var textView: UITextView!;
    var chulkView: UIView!;
    
    var delegate: MPDraggableTextViewDelegate?;
    
    public var textColor: UIColor = UIColor.black {
        didSet {
            textView.textColor = textColor;
        }
    }
    
    public var fontSize: CGFloat = 5 {
        didSet {
            textView.font = UIFont.systemFont(ofSize: fontSize);
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);

        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.detectPan(recognizer:)));
        
        self.addGestureRecognizer(pan);
        
        textView = UITextView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height));
        textView.returnKeyType = .done;
        textView.isEditable = true;
        textView.isSelectable = true;
        textView.backgroundColor = UIColor.clear;
        textView.font = UIFont.systemFont(ofSize: 17);
        textView.text = "Type Here";
        textView.isScrollEnabled = false;
        textView.delegate = self;
        self.addSubview(textView);
        
        
        chulkView = UIView(frame:CGRect(x: 0, y: 0, width: 50, height: 50));
        chulkView.backgroundColor = UIColor.green;
        chulkView.center = CGPoint(x: frame.width, y: frame.height);
        self.addSubview(chulkView);
        
        
        let chulkPan = UIPanGestureRecognizer(target: self, action: #selector(self.detectChulkPan(recognizer:)));
        
        chulkView.addGestureRecognizer(chulkPan);
 
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectChulkPan(recognizer:UIPanGestureRecognizer) {
        if recognizer.state == .began {
            lastChulkLocation = chulkView.center;
        } else {
            let translation = recognizer.translation(in: self);
            
            let final = CGPoint(x: lastChulkLocation.x + translation.x, y: lastChulkLocation.y + translation.y);
            if final.x < 25 || final.y < 25  {
              return;
            }
            
            chulkView.center = final;
            
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: chulkView.center.x, height: chulkView.center.y);
            
            print("center \(chulkView.center.x, chulkView.center.y)");
            textView.frame = CGRect(x: 0, y: 0, width: chulkView.center.x, height: chulkView.center.y);
            
        }
        
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        if recognizer.state == .began {
            lastLocation = self.center;
        } else {
            let translation = recognizer.translation(in: self.superview);
            
            self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y);
        }
        
    }
    
    //UITextViewDelegate
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.delegate?.draggableTextViewDidBeginEditing(self);
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder();
            self.delegate?.draggableTextViewDidEndEditing(self);
            return false;
        }
        return true;
    }
}

