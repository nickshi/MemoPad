//
//  ColorsManager.swift
//  MemoPad
//
//  Created by nick.shi on 3/11/17.
//  Copyright © 2017 nick.shi. All rights reserved.
//

import UIKit

class ColorsManager{
    
    private init() {
        loadColors();
    }
    
    static let sharedManager:ColorsManager  = ColorsManager();
    var colors:[UIColor] = [UIColor]();
    func loadColors() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let documentsDirectory = paths[0] as String;
        let path = documentsDirectory.stringByAppendingPathComponent(path: "Colors.plist");
        let fileManager = FileManager.default;
        if !fileManager.fileExists(atPath: path) {
            let bundleColorsFile = Bundle.main.path(forResource: "Colors", ofType: "plist");
            do {
               try fileManager.copyItem(atPath: bundleColorsFile!, toPath: path);
            } catch {
                
            }
            
        }
        
        let arr = NSArray(contentsOfFile: path);
        
        if let aAry = arr {
            for item in aAry {
                let str = item as! String;
                let coms = str.components(separatedBy: "#");
                if coms.count == 3 {
                    let red = (coms[0] as NSString).floatValue;
                    let green = (coms[1] as NSString).floatValue;
                    let blue = (coms[2] as NSString).floatValue;
                    
                    let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1);
                    colors.append(color);
                }
            }
        }
    }
    
    private func saveColor(color: UIColor) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true);
        let documentsDirectory = paths[0] as String;
        let path = documentsDirectory.stringByAppendingPathComponent(path: "Colors.plist");
        
        if let plistArray = NSMutableArray(contentsOfFile: path) {
            plistArray.add("\(color.red())#\(color.green())#\(color.blue())");
            plistArray.write(toFile: path, atomically: true);
        }

    }
    
    func addColor(color: UIColor) {
        colors.append(color);
        saveColor(color: color);
    }

}

