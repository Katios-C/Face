import Foundation
import MLKit
import SwiftUI

class FaceDetection {
    
    var noseX: CGFloat = 0
    var noseY: CGFloat = 0
    
    var width: CGFloat = 100
    var height: CGFloat = 100
    
    var nosePos: ((_ x: CGFloat, _ y: CGFloat, _ error: Error?) -> ())?
    
    func detectSetting(img: UIImage) {
        print("img.size")
        print(img.size)
        
        let options = FaceDetectorOptions()
        options.performanceMode =  .accurate
        options.landmarkMode = .all
        options.classificationMode = .all
    
        
        // Real-time contour detection of multiple faces
        options.contourMode = .all
        
       
        
        let image = VisionImage(image: img)
        
        print("this is image: \(image)")
        image.orientation = img.imageOrientation
     
    
        let faceDetector = FaceDetector.faceDetector(options: options)
        
        weak var weakSelf = self
        faceDetector.process(image) { faces, error in
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            guard error == nil, let faces = faces, !faces.isEmpty else {
                
                print("Face is nil!")
                print(error)
                self.nosePos?(0, 0, FaceDetectionError.faceIsNil)
                return
            }
            print("faces.count")
            print(faces.count)
            // Faces detected
            
            for face in faces {
                let frame = face.frame
                
                if face.hasHeadEulerAngleX {
                    let rotX = face.headEulerAngleX
                  
                    // Head is rotated to the uptoward rotX degrees
                }
                if face.hasHeadEulerAngleY {
                    let rotY = face.headEulerAngleY  // Head is rotated to the right rotY degrees
                }
                if face.hasHeadEulerAngleZ {
                    let rotZ = face.headEulerAngleZ  // Head is tilted sideways rotZ degrees
                }
                
                // If landmark detection was enabled (mouth, ears, eyes, cheeks, and
                // nose available):
                
                if let nose = face.landmark(ofType: .noseBase){
                    let nosePosition = nose.position
                    
//                    self.noseX = nosePosition.x
//                    self.noseY = nosePosition.y
                    self.nosePos?(nosePosition.x, nosePosition.y, nil)
                    
                    print(nosePosition.x)
                    print((nosePosition.y))
                }
                
                
                if let leftEye =
                    face.landmark(ofType: .leftEye) {
                    let leftEyePosition = leftEye.position
                    
                }
                
                // If contour detection was enabled:
                if let leftEyeContour = face.contour(ofType: .leftEye) {
                    let leftEyePoints = leftEyeContour.points
                    
                }
                if let upperLipBottomContour = face.contour(ofType: .upperLipBottom) {
                    let upperLipBottomPoints = upperLipBottomContour.points
                }
                
                
                // If classification was enabled:
                if face.hasSmilingProbability {
                    let smileProb = face.smilingProbability
                }
                if face.hasRightEyeOpenProbability {
                    let rightEyeOpenProb = face.rightEyeOpenProbability
                }
                
                // If face tracking was enabled:
                if face.hasTrackingID {
                    let trackingId = face.trackingID
                }
            }
        }
    }
    
    
    func drawLogoIn(_ image: UIImage, _ logo: UIImage, position: CGPoint) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: image.size)
         
        if position.x == 0 && position.y == 0 {
            print("NO nose found")
        }
        return renderer.image { context in
            image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
            logo.draw(in: CGRect(origin: position, size: size))
        }
    }
    
    
   
    
    
}
