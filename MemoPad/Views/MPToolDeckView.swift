//
//  MemoToolDeckView.swift
//  MemoPad
//
//  Created by nick.shi on 2/20/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPToolDeckViewDelegate {
    func toolDeckView(_ tooldeckview: MPToolDeckView, selectedLineWidth width:Int);
    func toolDeckView(_ tooldeckview: MPToolDeckView, didSelectEarser eraser:Bool);
    func toolDeckView(_ tooldeckview: MPToolDeckView, currentTool pen:Tools);
    func toolDeckView(_ tooldeckview: MPToolDeckView, selectedFontSize size:Int);
}

class MPToolDeckView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: MPToolDeckViewDelegate?;
    //lineWidth
    var btnLineWidth1: UIButton!;
    var btnLineWidth2: UIButton!;
    var btnLineWidth3: UIButton!;
    //textFontSize
    var btnFontSize1: UIButton!;
    var btnFontSize2: UIButton!;
    var btnFontSize3: UIButton!;
    
    var btnCurrentTools: UIButton!;
    var btnEraser: UIButton!;
    
    var currentPlateView: UIView!;
    
    
    var currentTool: Tools = .all {
        didSet {
            if oldValue != .eraser {
               previousTools = oldValue;
            }
            setupSubViewWithTool(tool: currentTool);
        }
    }
    var previousTools: Tools = .pencil;
    
    public var currentColor = UIColor.white {
        didSet {
            currentPlateView.backgroundColor = currentColor;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        let height: CGFloat = 30;
        let y = (frame.height - height) / 2;
        //lineWidth
        btnLineWidth1 = UIButton(frame: CGRect(x: 0, y: y, width: 30, height: 30));
        btnLineWidth1.setTitleColor(UIColor.black, for: .normal);
        btnLineWidth1.layer.borderWidth = 1;
        btnLineWidth1.layer.cornerRadius = 15;
        btnLineWidth1.setTitle("1", for: .normal);
        btnLineWidth1.tag = 1;
        btnLineWidth1.addTarget(self, action: #selector(MPToolDeckView.lineWidthPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnLineWidth1);
        
        btnLineWidth2 = UIButton(frame: CGRect(x: 50, y: y, width: 30, height: 30));
        btnLineWidth2.setTitleColor(UIColor.black, for: .normal);
        btnLineWidth2.layer.borderWidth = 1;
        btnLineWidth2.layer.cornerRadius = 15;
        btnLineWidth2.setTitle("5", for: .normal);
        btnLineWidth2.tag = 5;
        btnLineWidth2.addTarget(self, action: #selector(MPToolDeckView.lineWidthPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnLineWidth2);
        
        btnLineWidth3 = UIButton(frame: CGRect(x: 100, y: y, width: 30, height: 30));
        btnLineWidth3.setTitleColor(UIColor.black, for: .normal);
        btnLineWidth3.layer.borderWidth = 1;
        btnLineWidth3.layer.cornerRadius = 15;
        btnLineWidth3.setTitle("10", for: .normal);
        btnLineWidth3.tag = 10;
        btnLineWidth3.addTarget(self, action: #selector(MPToolDeckView.lineWidthPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnLineWidth3);
        
        
        //textFontSize
        btnFontSize1 = UIButton(frame: CGRect(x: 0, y: y, width: 30, height: 30));
        btnFontSize1.setTitleColor(UIColor.black, for: .normal);
        btnFontSize1.layer.borderWidth = 1;
        btnFontSize1.layer.cornerRadius = 15;
        btnFontSize1.setTitle("1", for: .normal);
        btnFontSize1.tag = 15;
        btnFontSize1.addTarget(self, action: #selector(MPToolDeckView.textFontSizePressed(sender:)), for: .touchUpInside);
        self.addSubview(btnFontSize1);

        
        btnFontSize2 = UIButton(frame: CGRect(x: 50, y: y, width: 30, height: 30));
        btnFontSize2.setTitleColor(UIColor.black, for: .normal);
        btnFontSize2.layer.borderWidth = 1;
        btnFontSize2.layer.cornerRadius = 15;
        btnFontSize2.setTitle("5", for: .normal);
        btnFontSize2.tag = 20;
        btnFontSize2.addTarget(self, action: #selector(MPToolDeckView.textFontSizePressed(sender:)), for: .touchUpInside);
        self.addSubview(btnFontSize2);
  
        
        btnFontSize3 = UIButton(frame: CGRect(x: 100, y: y, width: 30, height: 30));
        btnFontSize3.setTitleColor(UIColor.black, for: .normal);
        btnFontSize3.layer.borderWidth = 1;
        btnFontSize3.layer.cornerRadius = 15;
        btnFontSize3.setTitle("10", for: .normal);
        btnFontSize3.tag = 25;
        btnFontSize3.addTarget(self, action: #selector(MPToolDeckView.textFontSizePressed(sender:)), for: .touchUpInside);
        self.addSubview(btnFontSize3);
 
        
        
        btnCurrentTools = UIButton(type: .custom);
        btnCurrentTools.frame = CGRect(x: 150, y: y, width: 35, height: 35);
        btnCurrentTools.setImage(#imageLiteral(resourceName: "Pencil-100"), for: .normal);
        btnCurrentTools.setImage(#imageLiteral(resourceName: "Pencil Filled_100"), for: .selected);
        btnCurrentTools.addTarget(self, action: #selector(self.currentToolPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnCurrentTools);
        
        btnEraser = UIButton(frame: CGRect(x: 200, y: 0, width: 50, height: 50));
        btnEraser.setImage(#imageLiteral(resourceName: "Eraser"), for: .normal);
        btnEraser.setImage(#imageLiteral(resourceName: "Eraser Filled"), for: .selected);
        btnEraser.addTarget(self, action: #selector(MPToolDeckView.eraserPressed(sender:)), for: .touchUpInside);
        self.addSubview(btnEraser);
        
        let plateWidth: CGFloat = 35;
        currentPlateView = UIView(frame: CGRect(x: frame.width - plateWidth - 10, y: (frame.height - plateWidth) / 2, width: plateWidth, height: plateWidth));
        currentPlateView.layer.cornerRadius = plateWidth/2;
        currentPlateView.backgroundColor = UIColor.black;
        self.addSubview(currentPlateView);
        
        currentTool = .pencil;
        setupSubViewWithTool(tool: currentTool);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViewWithTool(tool: Tools) {
        btnLineWidth1.isHidden = (tool == Tools.text)
        btnLineWidth2.isHidden = (tool == Tools.text)
        btnLineWidth3.isHidden = (tool == Tools.text);
        btnFontSize1.isHidden = (tool != Tools.text)
        btnFontSize2.isHidden = (tool != Tools.text)
        btnFontSize3.isHidden = (tool != Tools.text);
        btnEraser.isHidden = (tool == Tools.text);
        if tool == Tools.pencil {
            btnCurrentTools.setImage(#imageLiteral(resourceName: "Pencil-100"), for: .normal);
            btnCurrentTools.setImage(#imageLiteral(resourceName: "Pencil Filled_100"), for: .selected);
            btnCurrentTools.isSelected = true;
            btnEraser.isSelected = false;
        } else if tool == .text {
            btnCurrentTools.setImage(#imageLiteral(resourceName: "Text Box Filled_100"), for: .normal);
            btnCurrentTools.isSelected = false;
        } else if tool == .eraser {
            btnEraser.isSelected = true;
            btnCurrentTools.isSelected = false;
        }
        
    }
    
    func lineWidthPressed(sender: UIButton) {
        delegate?.toolDeckView(self, selectedLineWidth: sender.tag)
    }
    
    func currentToolPressed(sender: UIButton) {
        
        delegate?.toolDeckView(self, currentTool: sender.isSelected ? .all : previousTools);

    }
    
    func eraserPressed(sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true;
        }

        delegate?.toolDeckView(self, didSelectEarser: true);
    }
    
    func textFontSizePressed(sender: UIButton) {
        delegate?.toolDeckView(self, selectedFontSize: sender.tag);
    }
}
