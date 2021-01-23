
class Cart {
    private(set) var pico : PicoRender
    init(_ pico: PicoRender) {
        self.pico = pico
    }
    func initCart() {
    }
    func draw() {
        fatalError("Subclasses need to implement the `draw()` method.")
    }
}
