import XCTest
import JSON

class TestCase: XCTestCase {
    
    var testData: Data!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        guard let fileURL = Bundle(for: TestCase.self).url(forResource: "Test", withExtension: "json") else {
            XCTFail("Can't locate Test.json")
            return
        }
        
        do {
            testData = try Data(contentsOf: fileURL)
        } catch {
            XCTFail("Can't load Test.json <\(error)>")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
}
