
class Cart {
    private(set) var pico : PicoRender!
    func load(_ pico: PicoRender) {
        self.pico = pico
    }
    func initCart() {
    }
    func draw() {
        fatalError("Subclasses need to implement the `draw()` method.")
    }
}
