//
//  Cart4.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

/*
 q=.25
 q=.25
 function e(i)
    return sin(i)*64+64
 end
 ::l
 ::cls(1)
 i = t()/4
 a=sin(-i)*32+64
 b=cos(-i)*32+64
 y,z=e(i),e(i-q)
 for j=q,1,q do
     w,x,y,z=y,z,e(i+j),e(i+j-q)
     for k=0,1,q/2 do
        line(w+k*(a-w),x+k*(b-x),a+k*(y-a),b+k*(z-b),6+j*4)
     end
 end
 flip()goto l
 */

class Cart4 : Cart {
   
    private var q = 0.25
    
    private func e(_ i : Double)->Double {
        return pico.sin(i)*64+64
    }
    override func initCart() {
        q = 0.25
    }

    override func draw() {
        pico.cls(1)
        let i = pico.t()/4
        let a = pico.sin(-i)*32.0+64.0
        let b = pico.cos(-i)*32.0+64.0
        var y = e(i)
        var z = e(i-q)
        var w : Double = 0.0
        var x : Double = 0.0
        pico.forloop(start: q, end: 1, step: q) { j in
            w = y
            x = z
            y = e(i+j)
            z = e(i+j-q)
            
            pico.forloop(start: 0, end: 1.0, step: q/2.0) { k in
                let c = Int(6+j*4)
                pico.line(x1: w+k*(a-w), y1: x+k*(b-x), x2: a+k*(y-a), y2: b+k*(z-b), color: c)
            }
        }
    }
}
