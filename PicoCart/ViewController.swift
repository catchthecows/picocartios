//
//  ViewController.swift
//  PicoCart
//
//  Created by Scott Lund on 12/31/20.
//

import UIKit

class ViewController: UIViewController {
    
    var timer : Timer?
    let buffer = ScreenBufferView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        buffer.frame = CGRect(x: 0, y:0, width: 256, height: 256)
        view.addSubview(buffer)
        view.layoutSubviews()
        
        Timer.scheduledTimer(withTimeInterval:  1/60.0, repeats: true) { timer in
            self.redraw()           
        }

    }
    
    private func redraw() {
        buffer.setNeedsDisplay()
    }


}

