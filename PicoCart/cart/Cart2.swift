//
//  Cart2.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

/*
 s=sin
 c=cos
 d=circ
 function _draw()
     l=t()
     cls()
     pal({[0]=1,5,13,12,7,7})
     for i=0,31 do
         a=i/32+l/8
         x=64+c(a)*48
         y=64+s(a)*48
         d(x,y,32,s(a)*2+2)
         for j=0,15 do
             a=j/16+l/4
             x+=c(-a)*8
             y+=s(-a)*8
             d(x,y,8,s(a)*2+2.2)
             for k=0,7 do
                 a=k/8+l/2
                 x+=c(a)*4
                 y+=s(a)*4
                 d(x,y,4,s(a)*2+2.2)
             end
         end
     end
 end--
 */


class Cart2 : Cart {
    override func initCart() {
        pico.pal(index: 0, colors: [1,5,13,12,7,7], palette:0)
    }
    override func draw() {
        let t = pico.t()
        pico.cls(0)
        pico.forloop(start: 0, end: 31, step: 1) { i in
            var a = i/32 + t/8
            var x = 64 + pico.cos(a)*48
            var y = 64 + pico.sin(a)*48
            pico.circ(x: x, y: y, r: 32, color: Int(sin(a)*2+2))
            pico.forloop(start: 0, end: 15, step: 1) { j in
                a = j/16 + t/4
                x += pico.cos(-a)*8
                y += pico.sin(-a)*8
                pico.circ(x: x, y: y, r: 8, color: Int(sin(a)*2+2.2))
                
                pico.forloop(start: 0, end: 7, step: 1) { k in
                    a = k/8 + t/2
                    x += pico.cos(-a)*4
                    y += pico.sin(-a)*4
                    pico.circ(x: x, y: y, r: 4, color: Int(sin(a)*2+2.2))
                }

            }
        }
    }
}



    
