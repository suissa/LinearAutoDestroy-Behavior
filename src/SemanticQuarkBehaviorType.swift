public struct LinearAutoDestroy<T> {
    private var value: T?
    private var is_destroyed: Bool = false
    
    public init(val: T) {
        self.value = val
    }
    
    // Mutating garante que o estado nominal da struct mude ao ler
    public mutating func consume() throws -> T {
        if is_destroyed || value == nil {
            throw NSError(domain: "VariableAlreadyDestroyed", code: 1, userInfo: nil)
        }
        
        let extracted = value!
        self.value = nil // Zera a referência
        self.is_destroyed = true
        return extracted
    }
}
