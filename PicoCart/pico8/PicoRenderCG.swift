import UIKit
import CoreGraphics

class PicoRenderCG : PicoRender {
    private(set) var cart: Cart?
    
    init() {
        initPico()
    }
    
    func loadCart(_ cart: Cart) {
        self.cart = cart
        cart.load(self)
    }
    
    private func initPico() {
        initPalette()
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
    
    func forloop(start:Double, end:Double, step:Double, loop:(Double)->()) {
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
    func tick() {
        _t += 1.0/60.0
        cart?.draw()
    }
    
    func t()->Double {
        return _t
    }
    
    func sin(_ a: Double)->Double {
        return Foundation.sin(a * (Double.pi * 2))
    }
    
    func cos(_ a: Double)->Double {
        return Foundation.cos(a * (Double.pi * 2))
    }
    
    func cls(_ color : Int  = 0) {
        //rectfill(x1: 0, y1: 0, x2: bounds.width, y2: bounds.height, color: color)
        rectfill(x1: 0, y1: 0, x2: Double(256), y2: Double(256), color: color)
    }
    
    func flr(_ n : Double)->Double {
        return floor(n)
    }
    
    func line(x1:Double,y1:Double,x2:Double,y2:Double,color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(_get_color(color: color).cgColor)
            context.setLineWidth(1)
            context.beginPath()
            context.move(to: CGPoint(x: x1, y:y1))
            context.addLine(to: CGPoint(x: x2, y: y2))
            context.strokePath()
        }
    }
    
    func circ(x:Double,y:Double,r:Double,color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(_get_color(color: color).cgColor)
            let rect = CGRect(x: x-r, y: y-r, width: r*2, height: r*2)
            context.strokeEllipse(in: rect)
        }
    }
    
    func circfill(x:Double,y:Double,r:Double,color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(_get_color(color: color).cgColor)
            let rect = CGRect(x: x-r, y: y-r, width: r*2, height: r*2)
            context.fillEllipse(in: rect)
        }
    }
    
    func rectfill(x1:Double, y1:Double, x2:Double, y2:Double, color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(CGRect(x: x1, y: y1, width: x2-x1, height: y2-y1))
            context.setFillColor(_get_color(color: Int(color)).cgColor)
            context.fillPath()
        }
    }
    
    func rect(x1:Double, y1:Double, x2:Double, y2:Double, color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(CGRect(x: x1, y: y1, width: x2-x1, height: y2-y1))
            context.setStrokeColor(_get_color(color: Int(color)).cgColor)
            context.strokePath()
        }
    }
    
    func pget(x:Double, y:Double)->Int {
        return 0
    }
    
    func pset(x:Double, y:Double, color:Int) {
        if let context = UIGraphicsGetCurrentContext() {
            context.addRect(CGRect(x: Int(x), y: Int(y), width: 1, height: 1))
            context.setFillColor(_get_color(color: Int(color)).cgColor)
            context.fillPath()
        }
    }
    
    func pal(index: Int, color: Int, palette : Int = 0) {
        _palette[index] = system_palette[color]
    }
    
    func pal(index: Int, colors:[Int], palette: Int = 0) {
        var i = index
        colors.forEach() { color in
            _palette[i] = system_palette[color]
            i += 1
        }
    }
    
    func rnd(_ v : Double = 1.0)->Double {
        return Double.random(in: 0..<v)
    }
    
    func mid(min_value:Double, value:Double, max_value:Double)->Double {
        return min(max_value, max(min_value, value))
    }
    
}
