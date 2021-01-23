//
//  Cart7.swift
//  PicoCart
//
//  Created by David Lund on 1/23/21.
//

import Foundation


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
    
}
