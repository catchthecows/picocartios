//
//  PicoRenderPgetPset.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

class PicoRenderPgetPset : PicoRenderCG {
    static let SCREEN_SIZE = 128
    private var screen = [Int](repeating: 0, count: SCREEN_SIZE*SCREEN_SIZE)
    
    override func tick() {
        super.tick()
        for row in 0 ..< PicoRenderPgetPset.SCREEN_SIZE {
            for col in 0 ..< PicoRenderPgetPset.SCREEN_SIZE {
                let x = Double(col*2)
                let y = Double(row*2)
                rectfill(x1: x, y1: y, x2: x+2.0, y2: y+2.0, color: screen[row*PicoRenderPgetPset.SCREEN_SIZE + col])
                //super.pset(x: Double(col), y: Double(row), color: screen[row*PicoRenderPgetPset.SCREEN_SIZE + col])
            }
        }
    }
    
    override
    func cls(_ color: Int = 0) {
        for i in 0 ..< PicoRenderPgetPset.SCREEN_SIZE*PicoRenderPgetPset.SCREEN_SIZE {
            screen[i]=color
        }
    }
    
    override
    func pget(x:Double, y:Double)->Int {
        let col = Int(x)
        let row = Int(y)
        if (col >= 0 &&
                row >= 0 &&
                col < PicoRenderPgetPset.SCREEN_SIZE &&
                row < PicoRenderPgetPset.SCREEN_SIZE) {
            return screen[row*PicoRenderPgetPset.SCREEN_SIZE + col]
        }
        return 0
    }
    
    override
    func pset(x:Double, y:Double, color:Int) {
        let col = Int(x)
        let row = Int(y)
        if (col >= 0 &&
                row >= 0 &&
                col < PicoRenderPgetPset.SCREEN_SIZE &&
                row < PicoRenderPgetPset.SCREEN_SIZE) {
            screen[row*PicoRenderPgetPset.SCREEN_SIZE + col] = color
        }
    }
}
