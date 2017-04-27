//
//  ColorPanelView.swift
//  MemoPad
//
//  Created by nick.shi on 2/20/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

protocol MPColorPanelViewDelegate {
    func colorPanel (_ colorPanel:MPColorPanelView,  _ selectedColor : UIColor);
    func addNewColor (_ colorPanel:MPColorPanelView);
}

class MPColorPanelView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var delegate: MPColorPanelViewDelegate?;
    
    var collectionView: UICollectionView!;
    var colorsAry: [UIColor] = [UIColor]();
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        
        colorsAry.append(contentsOf: ColorsManager.sharedManager.colors);

        
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.itemSize = CGSize(width: frame.height, height: frame.height);
        flowLayout.scrollDirection = .horizontal;

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: flowLayout);
        collectionView.register(MPColorPlateView.self, forCellWithReuseIdentifier: "Cell");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white;
        self.addSubview(collectionView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsAry.count + 1;
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MPColorPlateView;
        
        if indexPath.row < colorsAry.count {
            cell.backgroundColor = colorsAry[indexPath.row];
        } else {
            cell.backgroundColor = UIColor.white;
        }
        cell.plateType = indexPath.row < colorsAry.count ? .color : .add;
        return cell;
    }
    
    
    //UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < colorsAry.count {
            let col = colorsAry[indexPath.row];
            delegate?.colorPanel(self, col);
        } else {
            delegate?.addNewColor(self);
        }
        
    }
    
    public func reload() {
        colorsAry.removeAll();
        colorsAry.append(contentsOf: ColorsManager.sharedManager.colors);
        collectionView.reloadData();
    }
}
