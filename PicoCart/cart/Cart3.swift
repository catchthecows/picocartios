//
//  Cart3.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation


/*
 t=0
 g=16
 s=pset
 ::_::
 t+=.01
 for c=0,7 do
     for r=7,0,-1 do
         x=c*g
         y=r*g
         z=max(0,sin(t+(c*.7+r*3)*.2)*40-20)
         for d=0,z do
           k=abs(d-z)<1 and 13 or 1+(c+r*7)%12
           a=x-d
           b=y+d
           rectfill(a,b,a+g,b+g,k)
           s(a,b,0)
           s(a+g,b)
           s(a+g,b+g)
         end
         rect(a,b,a+g,b+g,0)
     end
 end
 flip()goto _
 */

class Cart3 : Cart {
    override func draw() {
        let g = 16.0
        var a = 0.0
        var b = 0.0
        
        pico.forloop(start: 0, end: 7, step: 1) { c in
            pico.forloop(start: 7, end: 0, step: -1) { r in
                let x = c * g
                let y = r * g
                let z = max(0,pico.sin(pico.t()+(c * 0.7+r*3)*0.2)*40-20)
                pico.forloop(start: 0, end: z, step: 1) { d in
                    a = x-d
                    b = y+d
                    
                    let j = 1+(Int(c+r*7.0))%8
                    let k = abs(d-z)<1 ? 13 : j
                    
                    a = x-d
                    b = y+d

                    pico.rectfill(x1: a, y1: b, x2: a+g, y2: b+g, color: k)
                    pico.pset(x: a, y: b, color: 0)
                    pico.pset(x: a+g, y: b, color: 0)
                    pico.pset(x: a+g, y: b+g, color: 0)
                }
                pico.rect(x1: a, y1: b, x2: a+g, y2: b+g, color: 0)
            }
        }
    }
}
