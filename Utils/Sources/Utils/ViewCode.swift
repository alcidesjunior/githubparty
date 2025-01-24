public protocol ViewCode {
    func setup()
    func setupComponent()
    func setupConstrain()
    func setupExtraConfiguration()
}

public extension ViewCode {
    func setup() {
        setupComponent()
        setupConstrain()
        setupExtraConfiguration()
    }
    
    func setupExtraConfiguration() {}
}
