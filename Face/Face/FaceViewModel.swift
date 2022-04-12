
import SwiftUI


class FaceViewModel: ObservableObject {
    
    private let faceDetection = FaceDetection()
 
    
    @Published var noseX: CGFloat = 0
    @Published var noseY: CGFloat = 0
    @Published var mouthX: CGFloat = 0
    @Published var mouthY: CGFloat = 0
    private var imgSave = UIImage(systemName: "circle")
    
    @Published var nosePoints = CGPoint(x: 0, y: 0)
    var mouthPoints = CGPoint(x: 0, y: 0)

    init() {
        faceDetection.nosePos = {x, y, error in
            DispatchQueue.main.async {

                self.noseX = 0
                self.noseY = 0
                self.nosePoints.x = x - self.faceDetection.width / 2
                self.nosePoints.y = y - self.faceDetection.height / 2

            }
        }
        
        faceDetection.mouthPos = {x, y, error in
            DispatchQueue.main.async {
                self.mouthX = 0
                self.mouthY = 0
                self.mouthPoints.x = x - self.faceDetection.width / 2
                self.mouthPoints.y = y - self.faceDetection.height / 2
            }
        }
   
    }
    
    func detectPoints(image: UIImage) {
        faceDetection.detectSetting(img: image)
        print("detectPoints")
    }

    
    func drawImg(_ image: UIImage) -> UIImage {
        imgSave = faceDetection.drawLogoIn(image, UIImage(systemName: "face.smiling")!, nosePoints)
        return imgSave!
        
    }
    
    func writeToPhotoAlbum() {
        faceDetection.writeToPhotoAlbum()
    }

    
}
