
protocol PicoRender {
    func forloop(start:Double, end:Double, step:Double, loop:(Double)->())
    func tick()
    func t()->Double
    func sin(_ a: Double)->Double
    
    func cos(_ a: Double)->Double
    
    func cls(_ color : Int )
    
    func flr(_ n : Double)->Double
    
    func line(x1:Double,y1:Double,x2:Double,y2:Double,color:Int)
    
    func circ(x:Double,y:Double,r:Double,color:Int)
    
    func circfill(x:Double,y:Double,r:Double,color:Int)
    
    func rectfill(x1:Double, y1:Double, x2:Double, y2:Double, color:Int)
    
    func rect(x1:Double, y1:Double, x2:Double, y2:Double, color:Int)
    
    func pset(x:Double, y:Double, color:Int)
    
    func pal(index: Int, color: Int, palette : Int )
    
    func pal(index: Int, colors:[Int], palette: Int )
    
    func rnd(_ v : Double )->Double

}
