

import Foundation
import MLKit
import SwiftUI

class FaceDetection {
    
//    var leftEyePositionX: CGFloat = 0
//    var leftEyePositionY: CGFloat = 0
    
        var noseX: CGFloat = 0
        var noseY: CGFloat = 0
    
    var width: CGFloat = 100
    var height: CGFloat = 100
    
    var nosePos: ((_ x: CGFloat, _ y: CGFloat) -> ())?
    
    func detectSetting(img: UIImage) {
        
    let options = FaceDetectorOptions()
    options.performanceMode = .accurate
    options.landmarkMode = .all
    options.classificationMode = .all

    // Real-time contour detection of multiple faces
     options.contourMode = .all
        
        let image = VisionImage(image: img)
        
      //  image.orientation = img.imageOrientation
        
        let faceDetector = FaceDetector.faceDetector(options: options)
        
        
        weak var weakSelf = self
        faceDetector.process(image) { faces, error in
          guard let strongSelf = weakSelf else {
            print("Self is nil!")
            return
          }
          guard error == nil, let faces = faces, !faces.isEmpty else {
        
            return
          }

          // Faces detected
        
            for face in faces {
              let frame = face.frame
                
              if face.hasHeadEulerAngleX {
                let rotX = face.headEulerAngleX
                  print("frame")
                  print(frame)
                                    
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
                    print("nosePosition")
                    print(nosePosition.x)
                    print(nosePosition.y)
                    
                    self.noseX = nosePosition.x
                    self.noseY = nosePosition.y
                    self.nosePos?(nosePosition.x, nosePosition.y)
                }
                    
                    
                if let leftEye =
                    face.landmark(ofType: .leftEye) {
                  let leftEyePosition = leftEye.position
                    
//                  self.leftEyePositionX = leftEyePosition.x
//                  self.leftEyePositionY = leftEyePosition.y
                  
//                  print("leftEyePosition")
//                    print(leftEyePosition.x)
                  
//                  self.leftEyeCompletion?(leftEyePosition.x, leftEyePosition.y)
              }

              // If contour detection was enabled:
              if let leftEyeContour = face.contour(ofType: .leftEye) {
                let leftEyePoints = leftEyeContour.points
                  
//                  print("leftEyePoints.first?.x")
//                 print( leftEyePoints.first?.x)
//                  print(leftEyePoints.first?.y)
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
    
    func drawOnImage(_ image: UIImage) -> UIImage {
         
         // Create a context of the starting image size and set it as the current one
         UIGraphicsBeginImageContext(image.size)
         
         // Draw the starting image in the current context as background
         image.draw(at: CGPoint.zero)

         // Get the current context
         let context = UIGraphicsGetCurrentContext()!

         // Draw a red line
//         context.setLineWidth(2.0)
//         context.setStrokeColor(UIColor.red.cgColor)
//         context.move(to: CGPoint(x: 100, y: 100))
//         context.addLine(to: CGPoint(x: 1500, y: 1950))
//         context.strokePath()
         
         // Draw a transparent green Circle
         context.setStrokeColor(UIColor.green.cgColor)
         context.setAlpha(0.5)
         context.setLineWidth(10.0)
         context.addEllipse(in: CGRect(x: noseX - 60, y: noseY - 60, width: width, height: height))
         context.drawPath(using: .stroke) // or .fillStroke if need filling
        
   
        
    
         // Save the context as a new UIImage
         let myImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         // Return modified image
        
         return myImage ?? image
    }
    
    
     func drawLogoIn(_ image: UIImage, _ logo: UIImage, position: CGPoint) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: image.size)
         
        return renderer.image { context in
            image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
            logo.draw(in: CGRect(origin: position, size: size))
        }
    }

    func loadImage(inputImage: UIImage?,  image: inout Image) {

        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
   
    }
    
}
