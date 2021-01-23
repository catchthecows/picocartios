//
//  Cart5.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

/*
 ::_::
 cls()
 for i=-8,136,8do
     for j=-8,136,6do
         x=i-64
         y=j-64
         s=3*sin(y/32+cos(x/180-t()/4)+t()/2)+flr(j/6%2)*10
         if(j!=-8)line(i+s,j,n,m,7)
         n=i+s
         m=j
     end
 end
 flip()
 goto _
 */

class Cart5: Cart {
    
   
    override func draw() {
        pico.cls(0)
        var n = 0.0
        var m = 0.0
        pico.forloop(start: -8, end: 136, step: 8) { i in
            pico.forloop(start: -8, end: 136, step: 8) { j in
                let x = i-64
                let y = j-64
                let k = Double(Int(j/6)%2)
                let s=3*pico.sin(y/32+pico.cos(x/180-pico.t()/4)+pico.t()/2)+pico.flr(k)*10
                if (j != -8) {
                    pico.line(x1: i+s, y1: j, x2: n, y2: m, color: 7)
                }
                n = i+s
                m = j
            }
        }
    }
        
}
