//
//  Cart6.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

/*
 for i=1,5do
 pal(i-1,({129,1,140,12,7})[i],1)
 end
 ::_::
 cls(0)
 b=32
 d=64+32*cos(t()/4)
 e=64-32*sin(t()/4)
 for i=-10,138,5do
 for j=-10,138,5do
 c=5-sqrt((i-d)^2+(j-e)^2)/b
 u=i+5*cos(t()+j/64+i/64)
 v=j+5*sin(t()-64+i/128+j/0.1)
 pset(u,v,c)end
 end
 flip()goto _
 */

class Cart6 : Cart {

    override func initCart() {
        pico.pal(index: 0, colors: [129,1,140,12,7], palette: 0)
    }
    
    override func draw() {
        pico.cls(0)
        let b = 32.0
        let d = 64.0+32*pico.cos(pico.t()/4)
        let e = 64.0-32*pico.sin(pico.t()/4)
        pico.forloop(start: -10, end: 138, step: 5) { i in
            pico.forloop(start: -10, end: 138, step: 5) { j in
                let aa = (i - d) * (i - d)
                let bb = (j - e) * (j - e)
                let cc = (aa+bb).squareRoot()
                let c = 5.0 - (cc/b)
                let u = i+5*pico.cos(pico.t()+j/64+i/64)
                let v = j+5*pico.sin(pico.t()-64+i/128+j/0.1)
                pico.pset(x: u, y: v, color: Int(c))
            }
        }
    }
    
    
}
