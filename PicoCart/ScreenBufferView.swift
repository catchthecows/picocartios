//
//  ScreenBufferView.swift
//  PicoCart
//
//  Created by Scott Lund on 12/31/20.
//

import UIKit
import CoreGraphics

class ScreenBufferView: UIView {
    private var pico : PicoRender!
    private var cart : Cart!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPico()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initPico()
    }
    
    private func initPico() {
        pico = PicoRenderCG()
        cart = Cart6(pico)
        cart.initCart()
    }
    
    override func draw(_ rect: CGRect) {
        pico.tick()
        cart.draw()
    }

}

