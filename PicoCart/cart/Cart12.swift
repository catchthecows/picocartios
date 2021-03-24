//
//  Cart12.swift
//  PicoCart
//
//  Created by David Lund on 1/26/21.
//

import Foundation

/*
 pal({3,11,7},1)
 pal(4,3)pal(15,0)
 ⧗=0
 ::☉::
 local x,y,n=rnd(128),rnd(128),0
 for i=0,24 do
   n+=pget(x+(i%5)-2,y+(i\5)-2)
 end
 pset(x,y,pget(x,y)-sgn(n-24))
 ⧗+=1
 if(⧗==599) do
   memcpy(0x6000,0x6040,0x1fc0)
   memset(0x7fc0,0,0x40)
   flip()
   ⧗=0
 end
 goto ☉
 */
class Cart12 : Cart {
    private var count = 0
    override
     func initCart() {
        pico.cls(0)
        pico.pal(index: 1, colors: [3,11,7], palette: 1)
        pico.pal(index: 4, color: 3, palette: 0)
        pico.pal(index: 5, colors: [0,0,0,0,0,0,0,0,0,0,0], palette: 0)
    }
    override
     func draw() {
        pico.forloop(start: 0, end: 80, step: 1) { _ in
            let x = pico.rnd(128.0)
            let y = pico.rnd(128.0)
            var n : Double = 0.0
            
            pico.forloop(start: 0.0, end: 24.0, step: 1.0) { i in
                let gx = x+i.truncatingRemainder(dividingBy: 5.0)-2.0
                let gy = y+(i/5.0)-2
                n += Double(pico.pget(x: gx, y: gy))
            }
            let c = pico.pget(x: x, y: y)-Int(pico.sgn(n-24.0))
            print("COLOR \(c%16)")
            pico.pset(x: x, y: y, color: c)
            count += 1
            if (count == 599) {
                pico.scrollUp()
                count  = 0
            }
        }
    }
}
