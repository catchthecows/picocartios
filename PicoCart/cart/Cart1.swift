
import Foundation

    /*
     f=128
     l={}
     r=rnd
     for i=1,80do
         add(l,{a=r(),c=i%15+1,s=r(15),x=r(f),y=r(f)})
     end
     ::_::
     cls()
     for c in all(l)do
         c.a+=r(.2)-.1
         s=c.s
         c.x=c.x%f+cos(c.a)
         c.y=c.y%f+sin(c.a)
         circfill(c.x,c.y,s^0.5,c.c)
         for d in all(l)do
             if(d.s<s and(c.x-d.x)^2+(c.y-d.y)^2<s)
                 del(l,d)
                 c.s+=d.s
         end
     end
     flip()goto _
     */
    
    
    
class Cart1 : Cart {
    let f = 256.0
    struct ball {
        var a : Double
        var c : Int
        var s : Double
        var x : Double
        var y : Double
        var dead : Bool
    }
    var l = [ball]()
    
    override
    func initCart() {
        pico.forloop(start: 1, end: 80, step: 1) { i in
            l.append( ball(a: pico.rnd(1), c: Int(i)%15+1, s: (pico.rnd(5)+1) * 5, x: pico.rnd(f), y: pico.rnd(f), dead: false) )
        }
    }
    override
    func draw() {
        pico.cls(0)

        l.sort() { b1, b2 in
            return b2.s > b1.s
        }
        for (index,value) in l.enumerated() {
            if (value.dead == false) {
                l[index].a += pico.rnd(0.2)-0.1
                let s = value.s
                let x = min(max(0,value.x + pico.cos(value.a)),f)
                let y = min(max(0,value.y + pico.sin(value.a)),f)
                l[index].x = x
                l[index].y = y
                pico.circfill(x: x, y: y, r: s, color: value.c)
                
                for (i,b) in l.enumerated() {
                    if (b.dead == false && index != i) {
                        let ydist = (y-b.y)*(y-b.y)
                        let xdist = (x-b.x)*(x-b.x)
                        let dist = sqrt(xdist+ydist)
                        if(b.s<s && dist < s) {
                            l[index].s += 4
                            l[i].dead = true
                        }
                    }
                }
            }
        }
    }
}
