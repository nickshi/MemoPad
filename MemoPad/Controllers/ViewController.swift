//
//  ViewController.swift
//  MemoPad
//
//  Created by nick.shi on 2/20/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
MPColorPanelViewDelegate,
MPToolDeckViewDelegate,
MPOperationBarViewDelegate,
MPSketchViewDelegate,
MPDraggableTextViewDelegate,
MPTopConfirmViewDelegate,
MPToolListViewDelegate,
MPColorPickerDelegate
{
    
    var sketchView: MPSketchView!;
    var colorPanel: MPColorPanelView!;
    var deckView: MPToolDeckView!;
    var operationBarView: MPOperationBarView!;
    var draggableView: MPDraggableTextView?;
    var topConfirmView: MPTopConfirmView!;
    var toolListView: MPToolListView!;
    var colorPickerView: MPColorPicker!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor.black;
        setupViews();
        
    }
    
    func setupViews() {
        sketchView = MPSketchView(frame: UIScreen.main.bounds);
//        sketchView.layer.borderWidth = 1;
//        sketchView.layer.cornerRadius = 20.0;
        sketchView.delegate = self;
        self.view.addSubview(sketchView);
        
        colorPanel = MPColorPanelView(frame: CGRect(x: 0, y: self.view.frame.height - 90, width: self.view.frame.width, height: 35));
        colorPanel.delegate = self;
        self.view.addSubview(colorPanel);
        
        deckView = MPToolDeckView(frame: CGRect(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 50));
        deckView.delegate = self;
        self.view.addSubview(deckView);
        
        
        operationBarView = MPOperationBarView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50));
        operationBarView.delegate = self;
        self.view.addSubview(operationBarView);
        
        
        topConfirmView = MPTopConfirmView(frame: CGRect(x: 0, y: -50, width: self.view.frame.width, height: 50));
        topConfirmView.delegate = self;
        self.view.addSubview(topConfirmView);
        
        
        toolListView = MPToolListView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height));
        toolListView.delegate = self;
        //sketchView.currentTool = .text;
        
        colorPickerView = MPColorPicker(frame: CGRect(x: 0, y: (UIScreen.main.bounds.height - 300) / 2, width: self.view.frame.width, height: 300));
        colorPickerView.delegate = self;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MPColorPanelViewDelegate
    func colorPanel(_ colorPanel: MPColorPanelView, _ selectedColor: UIColor) {
        if sketchView.currentTool == .text {
            draggableView!.textColor = selectedColor;
        } else {
            sketchView.currentColor = selectedColor;
        }
        
        deckView.currentColor = selectedColor;

    }
    
    func addNewColor(_ colorPanel: MPColorPanelView) {
        self.view.addSubview(colorPickerView);
    }
    
    //MPToolDeckViewDelegate
    func toolDeckView(_ tooldeckview: MPToolDeckView, selectedLineWidth width: Int) {
        sketchView.currentLineWidth = CGFloat(width);
    }
    
    func toolDeckView(_ tooldeckview: MPToolDeckView, selectedFontSize size: Int) {
        draggableView?.fontSize = CGFloat(size);
    }
    
    func toolDeckView(_ tooldeckview: MPToolDeckView, currentTool pen: Tools) {
        if pen == .pencil {
            sketchView.currentTool = .pencil;
            deckView.currentTool = .pencil;
        } else {
            self.view.addSubview(self.toolListView);
        }
    }

    func toolDeckView(_ tooldeckview: MPToolDeckView, didSelectEarser eraser: Bool) {
        sketchView.currentTool = .eraser;
        deckView.currentTool = .eraser;
    }
    
    //MPOperationBarViewDelegate
    func operationBarView(operationBarView: MPOperationBarView, redo: Bool) {
        sketchView.redo();
    }
    
    func operationBarView(operationBarView: MPOperationBarView, undo: Bool) {
        sketchView.undo();
    }
    
    func operationBarView(operationBarView: MPOperationBarView, share: Bool) {
        let image: UIImage = sketchView.produceImage();
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil);
        self.present(activityViewController, animated: true) { 
            
        };
        
    }
    
    //MPSketchViewDelegate
    func sketchViewUpdateUndoRedoState(_ sketchView: MPSketchView) {
        operationBarView.canRedo = sketchView.canRedo;
        operationBarView.canUndo = sketchView.canUndo;
    }
    
    //MPDraggableTextViewDelegate
    func draggableTextViewDidEndEditing(_ textView: MPDraggableTextView) {
        
        topConfirmView.show();

    }
    
    func draggableTextViewDidBeginEditing(_ textView: MPDraggableTextView) {
        topConfirmView.hide();
    }
    
    //MPTopConfirmViewDelegate
    func topConfirmViewOK(_ topConfirmView: MPTopConfirmView) {
        topConfirmView.hide();
        let point = draggableView!.textView.convert(draggableView!.textView.center, to: self.sketchView);
        let layer = draggableView!.textView.layer;
        draggableView!.removeFromSuperview();
        sketchView.addTextLayer(layer, position: point);
        sketchView.currentTool = .pencil;
        deckView.currentTool = .pencil;
    }
    
    func topConfirmViewCancel(_ topConfirmView: MPTopConfirmView) {
        topConfirmView.hide();
        draggableView!.removeFromSuperview();
        sketchView.currentTool = .pencil;
        deckView.currentTool = .pencil;
    }
    
    
    //MPToolListViewDelegate
    func toolListView(_ toolListView: MPToolListView, didPenSelected pen: Bool) {
        topConfirmView.hide();
        sketchView.currentTool = .pencil;
        deckView.currentTool = .pencil;
    }
    
    func toolListView(_ toolListView: MPToolListView, didTextSelected text: Bool){
        if sketchView.currentTool != .text {
            deckView.currentTool = .text;
            sketchView.currentTool = .text;
            draggableView = MPDraggableTextView(frame: CGRect(x: 100, y: 100, width: 200, height: 200));
            draggableView!.delegate = self;
            draggableView!.textView.becomeFirstResponder();
            self.view.addSubview(draggableView!);
        }

    }
    
    //MPColorPickerDelegate
    func colorPickerOk(_ colorPicker: MPColorPicker, selectedColor: UIColor){
        ColorsManager.sharedManager.addColor(color: selectedColor);
        colorPanel.reload();
        colorPicker.removeFromSuperview();
    }
    func colorPickerCancel(_ colorPicker: MPColorPicker) {
        colorPicker.removeFromSuperview();
    }
    
    
}

