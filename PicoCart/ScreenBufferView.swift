//
//  ScreenBufferView.swift
//  PicoCart
//
//  Created by Scott Lund on 12/31/20.
//

import UIKit
import CoreGraphics

extension UIColor {
    convenience init?(hexRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexRGB.hasPrefix("#") ? hexRGB.dropFirst() : hexRGB[...])
        switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }
            case 6: break
            default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: alpha)
    }

}

class ScreenBufferView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPico()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initPico()
    }
    
    private func initPico() {
        initPalette()
        cart6_init()
    }
    
    private func initPalette() {
        system_palette.keys.forEach { key in
            if let v = system_palette[key] {
                _palette[key] = v
            }
        }
    }
    
    let system_palette = [
          0 : UIColor(hexRGB:"#000000"),
          1 : UIColor(hexRGB:"#1D2B53"),
          2 : UIColor(hexRGB:"#7E2553"),
          3 : UIColor(hexRGB:"#008751"),
          4 : UIColor(hexRGB:"#AB5236"),
          5 : UIColor(hexRGB:"#5F574F"),
          6 : UIColor(hexRGB:"#C2C3C7"),
          7 : UIColor(hexRGB:"#FFF1E8"),
          8 : UIColor(hexRGB:"#FF004D"),
          9 : UIColor(hexRGB:"#FFA300"),
          10 : UIColor(hexRGB:"#FFEC27"),
          11 : UIColor(hexRGB:"#00E436"),
          12 : UIColor(hexRGB:"#29ADFF"),
          13 : UIColor(hexRGB:"#83769C"),
          14 : UIColor(hexRGB:"#FF77A8"),
          15 : UIColor(hexRGB:"#FFCCAA"),
          128 : UIColor(hexRGB:"#291814"),
          129 : UIColor(hexRGB:"#111D35"),
          130 : UIColor(hexRGB:"#422136"),
          131 : UIColor(hexRGB:"#125359"),
          132 : UIColor(hexRGB:"#742F29"),
          133 : UIColor(hexRGB:"#49333B"),
          134 : UIColor(hexRGB:"#A28879"),
          135 : UIColor(hexRGB:"#F3EF7D"),
          136 : UIColor(hexRGB:"#BE1250"),
          137 : UIColor(hexRGB:"#FF6C24"),
          138 : UIColor(hexRGB:"#A8E72E"),
          139 : UIColor(hexRGB:"#00B543"),
          140 : UIColor(hexRGB:"#065AB5"),
          141 : UIColor(hexRGB:"#754665"),
          142 : UIColor(hexRGB:"#FF6E59"),
          143 : UIColor(hexRGB:"#FF9D81")
    ]
    
    var _palette = [Int:UIColor?]()
    
    /*
     Index    Color    Hex    RGB    Name
     0        #000000    0, 0, 0    black
     1        #1D2B53    29, 43, 83    dark-blue
     2        #7E2553    126, 37, 83    dark-purple
     3        #008751    0, 135, 81    dark-green
     4        #AB5236    171, 82, 54    brown
     5        #5F574F    95, 87, 79    dark-grey
     6        #C2C3C7    194, 195, 199    light-grey
     7        #FFF1E8    255, 241, 232    white
     8        #FF004D    255, 0, 77    red
     9        #FFA300    255, 163, 0    orange
     10        #FFEC27    255, 236, 39    yellow
     11        #00E436    0, 228, 54    green
     12        #29ADFF    41, 173, 255    blue
     13        #83769C    131, 118, 156    lavender
     14        #FF77A8    255, 119, 168    pink
     15        #FFCCAA    255, 204, 170    light-peach

     Undocumented
     128        #291814    41,24,20    darkest-grey
     129        #111D35    17,29,53    darker-blue
     130        #422136    66,33,54    darker-purple
     131        #125359    18,83,89    blue-green
     132        #742F29    116,47,41    dark-brown
     133        #49333B    73,51,59    darker-grey
     134        #A28879    162,136,121    medium-grey
     135        #F3EF7D    243,239,125    light-yellow
     136        #BE1250    190,18,80    dark-red
     137        #FF6C24    255,108,36    dark-orange
     138        #A8E72E    168,231,46    light-green
     139        #00B543    0,181,67    medium-green
     140        #065AB5    6,90,181    medium-blue
     141        #754665    117,70,101    mauve
     142        #FF6E59    255,110,89    dark peach
     143        #FF9D81    255,157,129    peach

     */
    
    func _get_color(color:Int)->UIColor {
        let index = color & 0x8F
        if let c = _palette[index] {
            return c!
        }
        return UIColor.black
    }
    
    var t = 0.0
    
    
    func pico_for(start:Double, end:Double, step:Double, loop:(Double)->()) {
        var index = start
        if (step >= 0) {
            while (index <= end) {
                loop(index)
                index = index + step
            }
        } else {
            while (index >= end) {
                loop(index)
                index = index + step
            }
        }
    }
    
    var _t : Double = 0.0
    func pico_t()->Double {
        return _t
    }
    
    func pico_sin(_ a: Double)->Double {
        return sin(a * (Double.pi * 2))
    }
    
    func pico_cos(_ a: Double)->Double {
        return cos(a * (Double.pi * 2))
    }
    
    func pico_cls(_ color : Int  = 0) {
        //pico_rectfill(x1: 0, y1: 0, x2: bounds.width, y2: bounds.height, color: color)
        pico_rectfill(x1: 0, y1: 0, x2: Double(bounds.width), y2: Double(bounds.height), color: color)
    }
    
    func pico_flr(_ n : Double)->Double {
        return floor(n)
    }
    
    func pico_line(x1:Double,y1:Double,x2:Double,y2:Double,color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(_get_color(color: color).cgColor)
            context.setLineWidth(1)
            context.beginPath()
            context.move(to: CGPoint(x: x1, y:y1))
            context.addLine(to: CGPoint(x: x2, y: y2))
            context.strokePath()
        }
    }
    
    func pico_circ(x:Double,y:Double,r:Double,color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(_get_color(color: color).cgColor)
            let rect = CGRect(x: x-r, y: y-r, width: r*2, height: r*2)
            context.strokeEllipse(in: rect)
        }
    }
    
    func pico_circfill(x:Double,y:Double,r:Double,color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(_get_color(color: color).cgColor)
            let rect = CGRect(x: x-r, y: y-r, width: r*2, height: r*2)
            context.fillEllipse(in: rect)
        }
    }
    
    func pico_rectfill(x1:Double, y1:Double, x2:Double, y2:Double, color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(CGRect(x: x1, y: y1, width: x2-x1, height: y2-y1))
            context.setFillColor(_get_color(color: Int(color)).cgColor)
            context.fillPath()
        }
    }
    
    func pico_rect(x1:Double, y1:Double, x2:Double, y2:Double, color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(CGRect(x: x1, y: y1, width: x2-x1, height: y2-y1))
            context.setStrokeColor(_get_color(color: Int(color)).cgColor)
            context.strokePath()
        }
    }
    
    func pico_pset(x:Double, y:Double, color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(CGRect(x: x, y: y, width: 1, height: 1))
            context.setFillColor(_get_color(color: Int(color)).cgColor)
            context.fillPath()
        }
    }
    
    func pico_pal(index: Int, color: Int, palette : Int = 0) {
        _palette[index] = system_palette[color]
    }
    
    func pico_pal(index: Int, colors:[Int], palette: Int = 0) {
        var i = index
        colors.forEach() { color in
            _palette[i] = system_palette[color]
            i += 1
        }
    }
    
    func pico_rnd(_ v : Double = 1.0)->Double {
        return Double.random(in: 0..<v)
    }
    
    override func draw(_ rect: CGRect) {
        _t += 1.0/60.0
        cart6_draw()
    }
    
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
    func cart6_init() {
        pico_for(start: 1, end: 80, step: 1) { i in
            l.append( ball(a: pico_rnd(), c: Int(i)%15+1, s: (pico_rnd(5)+1) * 5, x: pico_rnd(f), y: pico_rnd(f), dead: false) )
        }
    }
    
    func cart6_draw() {
        pico_cls()

        l.sort() { b1, b2 in
            return b2.s > b1.s
        }
        for (index,value) in l.enumerated() {
            if (value.dead == false) {
                l[index].a += pico_rnd(0.2)-0.1
                let s = value.s
                let x = min(max(0,value.x + pico_cos(value.a)),f)
                let y = min(max(0,value.y + pico_sin(value.a)),f)
                l[index].x = x
                l[index].y = y
                pico_circfill(x: x, y: y, r: s, color: value.c)
                
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
    
    func cart5_init() {
        pico_pal(index: 0, colors: [129,1,140,12,7])
    }
    func cart5() {
        pico_cls(0)
        let b = 64.0
        let d = 128.0+64*pico_cos(pico_t()/4)
        let e = 128.0-64*pico_sin(pico_t()/4)
        pico_for(start: -10, end: 266, step: 5) { i in
            pico_for(start: -10, end: 266, step: 5) { j in
                let aa = (i - d) * (i - d)
                let bb = (j - e) * (j - e)
                let cc = (aa+bb).squareRoot()
                let c = 5.0 - (cc/b)
                let u = i+5*pico_cos(pico_t()+j/128+i/128)
                let v = j+5*pico_sin(pico_t()-128+i/256+j/0.1)
                pico_pset(x: u, y: v, color: Int(c))
            }
        }
    }
    
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
    func cart4_init() {
        pico_pal(index: 0, colors: [1,5,13,12,7,7])
    }
    func cart4() {
        let t = pico_t()
        pico_cls()
        pico_for(start: 0, end: 31, step: 1) { i in
            var a = i/32 + t/8
            var x = 64 + pico_cos(a)*48
            var y = 64 + pico_sin(a)*48
            pico_circ(x: x, y: y, r: 32, color: Int(sin(a)*2+2))
            pico_for(start: 0, end: 15, step: 1) { j in
                a = j/16 + t/4
                x += pico_cos(-a)*8
                y += pico_sin(-a)*8
                pico_circ(x: x, y: y, r: 8, color: Int(sin(a)*2+2.2))
                
                pico_for(start: 0, end: 7, step: 1) { k in
                    a = k/8 + t/2
                    x += pico_cos(-a)*4
                    y += pico_sin(-a)*4
                    pico_circ(x: x, y: y, r: 4, color: Int(sin(a)*2+2.2))
                }
 
            }
        }
    }
        
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
   
    
    func cart3() {
        //t += 0.01
        pico_cls()
        var n = 0.0
        var m = 0.0
        pico_for(start: -8, end: 136, step: 8) { i in
            pico_for(start: -8, end: 136, step: 8) { j in
                let x = i-64
                let y = j-64
                let k = Double(Int(j/6)%2)
                let s=3*pico_sin(y/32+pico_cos(x/180-pico_t()/4)+pico_t()/2)+pico_flr(k)*10
                if (j != -8) {
                    pico_line(x1: i+s, y1: j, x2: n, y2: m, color: 7)
                }
                n = i+s
                m = j
            }
        }
    }
        
    
    
    /*
     q=.25
     q=.25
     function e(i)
        return sin(i)*64+64
     end
     ::l
     ::cls(1)
     i = t()/4
     a=sin(-i)*32+64
     b=cos(-i)*32+64
     y,z=e(i),e(i-q)
     for j=q,1,q do
         w,x,y,z=y,z,e(i+j),e(i+j-q)
         for k=0,1,q/2 do
            line(w+k*(a-w),x+k*(b-x),a+k*(y-a),b+k*(z-b),6+j*4)
         end
     end
     flip()goto l
     */
    var q = 0.25
    private func e(_ i : Double)->Double {
        return pico_sin(i)*64+64
    }
    func cart_init2() {
        q = 0.25
    }
     func cart2() {
        pico_cls(1)
        let i = pico_t()/4
        let a = pico_sin(-i)*32.0+64.0
        let b = pico_cos(-i)*32.0+64.0
        var y = e(i)
        var z = e(i-q)
        var w : Double = 0.0
        var x : Double = 0.0
        pico_for(start: q, end: 1, step: q) { j in
            w = y
            x = z
            y = e(i+j)
            z = e(i+j-q)
            
            pico_for(start: 0, end: 1, step: q/2.0) { k in
                pico_line(x1: w+k*(a-w), y1: x+k*(b-x), x2: a+k*(y-a), y2: b+k*(z-b), color: Int(6+j*4))
            }
        }
    }
    
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
    
    func cart_init() {
        t = 0
    }
    func cart1() {
        t += 0.01
        let g = 16.0
        var a = 0.0
        var b = 0.0
        
        pico_for(start: 0, end: 7, step: 1) { c in
            pico_for(start: 7, end: 0, step: -1) { r in
                let x = c * g
                let y = r * g
                let z = max(0,pico_sin(pico_t()+(c * 0.7+r*3)*0.2)*40-20)
                pico_for(start: 0, end: z, step: 1) { d in
                    a = x-d
                    b = y+d
                    
                    let j = 1+(Int(c+r*7.0))%8
                    let k = abs(d-z)<1 ? 13 : j
                    
                    a = x-d
                    b = y+d

                    pico_rectfill(x1: a, y1: b, x2: a+g, y2: b+g, color: k)
                    pico_pset(x: a, y: b, color: 0)
                    pico_pset(x: a+g, y: b, color: 0)
                    pico_pset(x: a+g, y: b+g, color: 0)
                }
                pico_rect(x1: a, y1: b, x2: a+g, y2: b+g, color: 0)
            }
        }
    }
    

}

