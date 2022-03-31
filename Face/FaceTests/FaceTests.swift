

import XCTest
@testable import Face

class FaceTests: XCTestCase {

    private let faceDetect = FaceDetection()
    private var testImage = UIImage()
    
    override func setUpWithError() throws {
        testImage = UIImage(named: "yes1")!
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        //Given
        let expec = self.expectation(description: "Scaling")
        var testError: Error? = nil
        faceDetect.nosePos = { x, y, error in
            testError = error
            expec.fulfill()
        }
        
        //When
        faceDetect.detectSetting(img: testImage)
        waitForExpectations(timeout: 6, handler: nil)
        
        //Then
        XCTAssertNil(testError)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
