//
//  Cart7.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation

/*

 pal(b*16,({-15,1,-4,12,6,7})[b*7\1],1)
 g+=.004+c(b-m)*b/69
 r+=c(g)
 h-=sin(g)
 l=1+b\.96*4
 for a=0,1,.02-b/99do
 u=64+r*c(a)
 v=p+h+l*sin(a+b\.99/2)
 if(a<.5)
 u=62+c(b-m+a\.17/3)*9*b+a*9
 v=p+b*99
 pset(u,v,pget(u,v)+l)end
 end
 flip()goto _
 */

/*
 https://twitter.com/von_rostock/status/1335561340883251205
 
 c=cos
 ::_::
 cls(3)
 m=t()
 r=0
 g=0
 h=0
 p=9+4*c(m)
 for b=0,1,.02do
     pal(b*16,({-15,1,-4,12,6,7})[b*7\1],1)
     g+=.004+c(b-m)*b/69
     r+=c(g)
     h-=sin(g)
     l=1+b\.96*4
     for a=0,1,.02-b/99do
         u=64+r*c(a)
         v=p+h+l*sin(a+b\.99/2)
         if(a<.5)
            u=62+c(b-m+a\.17/3)*9*b+a*9
            v=p+b*99
         pset(u,v,pget(u,v)+l)
     end
 end
 flip()goto _
 
 a\.17 is integer division equivalent of flr(a/.17)
 */

class Cart7 : Cart {
    let colors = [-15,-15,1,-4,12,6,7]
    
    private func invertsin(_ a :Double)->Double {
        return 0 - pico.sin(a)
    }
    override func draw() {
        pico.cls(3)
        let m = pico.t()
        var r = 0.0
        var g = 0.0
        var h = 0.0
        let p = 9 * 4 * pico.cos(m)
        pico.forloop(start: 0, end: 1, step: 0.02) { b in
            let pi = pico.flr((b*7)/1)
            //let pi2 = pico.flr(b*7)
            //print ("pi \(pi) pi2 \(pi2)")
            pico.pal(index: Int(b*16), color: colors[Int(pi)], palette: 1)
            g += 0.004+pico.cos(b-m)*b/69
            r += pico.cos(g)
            h -= invertsin(g)
            let l = 1 + pico.flr(b/0.96) * 4
            pico.forloop(start: 0, end: 1, step: 0.02-b/99.0) { a in
                var u = 64.0 + r * pico.cos(a)
                var v = p +  h + l * invertsin(a+pico.flr(b/0.99)/2)
                if (a < 0.5) {
                    u = 62.0 + pico.cos(b-m+pico.flr(a/0.17)/3)*9*b+a*9
                    v = p + b * 99.0
                }
                
                pico.pset(x: u, y: v, color: pico.pget(x: u, y: v)+1)
            }
        }
    }
}
