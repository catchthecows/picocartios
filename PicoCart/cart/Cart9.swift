//
//  Cart9.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

/*
 x,y=64,64
 cls()
 ?"fire demon",0,11
 line(41,13,126,13)
 line(1,110,118,110)
 ?"♥",120,109,8
 ::_::
 x+=1-rnd(2)
 y+=1-rnd(2)
 x=mid(0,x,127)
 y=mid(17,y,106)
 pset(x,y,8+rnd(2))
 pset(rnd(128),rnd(90)+17,1)
 goto _
 */
class Cart9 : Cart {
    var x = 64.0
    var y = 64.0
    override func draw() {
        pico.forloop(start: 0, end: 40, step: 1) { n in
        x += 1 - pico.rnd(2)
        y += 1 - pico.rnd(2)
        x = pico.mid(min_value: 0, value: x, max_value: 127)
        y = pico.mid(min_value: 17, value: y, max_value: 106)
        pico.pset(x: x, y: y, color: 8+Int(pico.rnd(2)))
            pico.forloop(start: 0, end: 4, step: 1) { m in
            pico.pset(x: pico.rnd(128), y: pico.rnd(90)+17, color: 1)
            }
        }
    }
}
