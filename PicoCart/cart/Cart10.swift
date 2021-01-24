//
//  Cart10.swift
//  PicoCart
//
//  Created by David Lund on 1/24/21.
//

import Foundation

/*
 https://twitter.com/ctinney94/status/1348330970496307201
 
 cls()
 s=64
 ::★::
 for o=.2,min(.2+t()/30,.5),.1 do
   for i=0,1,.1 do
     x=s+sin(i+o)*s
     y=s-cos(i+o)*s
     w=s+sin(i+.1)*s
     z=s-cos(i+.1)*s
     l=t()/3%1
     pset(x+l*(w-x),y+l*(z-y),7+8*o)
   end
 end
 
 i=24576+rnd(8192)
 poke(i,peek(i-64)/4)
 
 goto ★
 */
class Cart10 : Cart {
    let s = 64.0
    override func initCart() {
        pico.cls(0)
    }
    override func draw() {
        pico.forloop(start: 0.2, end: min(0.2+pico.t()/30.0,0.5), step: 0.1) { o in
        //pico.forloop(start: 0.2, end: 0.5, step: 0.1) { o in
            pico.forloop(start: 0, end: 1, step: 0.1) { i in
                let x = s + pico.sin(i+o)*s
                let y = s - pico.cos(i+o)*s
                let w = s + pico.sin(i+0.1)*s
                let z = s - pico.cos(i+0.1)*s
                let l = (pico.t()/3.0).truncatingRemainder(dividingBy: 1.0)
                let cp = (8*o).truncatingRemainder(dividingBy: 3)
                pico.pset(x: x+l*(w-x), y: y+l*(z-y), color: Int(8+cp))
                let rx1 = pico.rnd(128)
                let ry1 = pico.rnd(128)
                let rx2 = pico.rnd(128)
                let ry2 = pico.rnd(128)
                pico.forloop(start: 0, end: 40, step: 1) { aa in
                    let cc = pico.pget(x: rx1, y: ry1)
                    if (cc > 0) {
                        pico.pset(x: rx1, y: ry1, color: pico.pget(x: rx2, y: ry2))
                    }
                }
            }
        }
    }
}
