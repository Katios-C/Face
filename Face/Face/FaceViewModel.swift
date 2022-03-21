
import SwiftUI


class FaceViewModel: ObservableObject {
    
    private let faceDetection = FaceDetection()
    
    @Published var noseX: CGFloat = 0
    @Published var noseY: CGFloat = 0
    
    var point = CGPoint(x: 0, y: 0)
    
    init() {
        faceDetection.nosePos = {x, y in
            DispatchQueue.main.async {
                
                self.noseX = x
                self.noseY = y
                
                self.point.x = x - self.faceDetection.width / 2
                self.point.y = y - self.faceDetection.height / 2

            }
            
            
        }
   
    }
    
    func fetectPoints(image: UIImage) {
        faceDetection.detectSetting(img: image)
        
      
    
    }
    
    
    
    func drawOnImage(_ image: UIImage) -> UIImage {
        faceDetection.drawOnImage(image)
        
    }
    
    
    func drawImg(_ image: UIImage) -> UIImage {
        print("1")
        return faceDetection.drawLogoIn(image, UIImage(systemName: "face.smiling")!, position: point)
    }
    
    func loadImage(inputImage: UIImage?,  image: inout Image) {
        faceDetection.loadImage(inputImage: inputImage, image: &image)
    }
    
}