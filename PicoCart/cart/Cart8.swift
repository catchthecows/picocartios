//
//  Cart8.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

/*
 ::_::
 for r=11,1,-1 do
   circfill(64,64,(r-t()%2)*10,(r%2)*7)
 end
 for x=0,63 do
   for y=0,63 do
     p=7-pget(x,y)
     pset(x,y,p)
     pset(128-x,128-y,p)
   end
 end
 flip()goto
 */
class Cart8 : Cart {
    override func draw() {
        pico.forloop(start: 11, end: 1, step: -1) { r in
            let tt = pico.t().truncatingRemainder(dividingBy: 2)
            pico.circfill(x: 64, y: 64, r: (r-tt)*10, color: (Int(r)%2)*7)
        }
    }
}
