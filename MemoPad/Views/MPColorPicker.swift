//
//  MPColorPicker.swift
//  MemoPad
//
//  Created by nick.shi on 3/11/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPColorPickerDelegate : class {
    func colorPickerOk(_ colorPicker: MPColorPicker, selectedColor: UIColor);
    func colorPickerCancel(_ colorPicker: MPColorPicker);
}
class MPColorPicker: UIView, MPColorPickerViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate: MPColorPickerDelegate?;
    var chooseColorView: UIView!;
    var colorPickerView: MPColorPickerView!;

    
    var btnOK: UIButton!;
    var btnCancel: UIButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        let chooseHeight: CGFloat = frame.height * 20.0 / 100;
        let btnHeight: CGFloat = frame.height * 15.0 / 100;
        let mainHeight: CGFloat = frame.height - chooseHeight - btnHeight;
        chooseColorView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: chooseHeight));
        self.addSubview(chooseColorView);
        
        
        colorPickerView = MPColorPickerView(frame: CGRect(x: 0, y: chooseHeight, width: frame.width, height: mainHeight));
        colorPickerView.delegate = self;
        self.addSubview(colorPickerView);
        colorPickerView.currentPoint = colorPickerView.center;
        
        btnOK = UIButton(frame: CGRect(x: 0, y: frame.height - btnHeight, width: frame.width / 2, height: btnHeight));
        btnOK.addTarget(self, action: #selector(self.btnOKPressed(sender:)), for: .touchUpInside);
        btnOK.backgroundColor = UIColor.white;
        btnOK.setTitle("OK", for: .normal);
        btnOK.setTitleColor(UIColor.black, for: .normal);
        self.addSubview(btnOK);
        
        btnCancel = UIButton(frame: CGRect(x: frame.width / 2, y: frame.height - btnHeight, width: frame.width / 2, height: btnHeight));
        btnCancel.addTarget(self, action: #selector(self.btnCancelPressed(sender:)), for: .touchUpInside);
        btnCancel.backgroundColor = UIColor.white;
        btnCancel.setTitle("Cancel", for: .normal);
        btnCancel.setTitleColor(UIColor.black, for: .normal);
        self.addSubview(btnCancel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //#MPColorPickerViewDelegate
    func colorPickerView(_ colorPickerView: MPColorPickerView, selectedColor color: UIColor) {
        chooseColorView.backgroundColor = color;
    }
    
    
    
    func btnOKPressed(sender: UIButton) {
        self.delegate?.colorPickerOk(self, selectedColor: chooseColorView.backgroundColor!);
    }
    
    func btnCancelPressed(sender: UIButton) {
        self.delegate?.colorPickerCancel(self);
    }

}
