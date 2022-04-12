import SwiftUI

struct ContentView: View {
    @ObservedObject private var faceViewModel = FaceViewModel()
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var image: Image?
    @State private var selImg: UIImage?
    @State private var isProccesed = false
    @State private var isLoaded = false
    
    var body: some View {
        VStack {
            
            isProccesed ?
            Image(uiImage: ((faceViewModel.drawImg(selImg!))))
                .resizable()
                .scaledToFit()
            
            :
            image?
                .resizable()
                .scaledToFit()
            
            Button("Make photo") {
                self.sourceType = .camera
                self.isImagePickerDisplay = true
                //  isLoaded = false
                
                loadImage()
                // isProccesed = false
                faceViewModel.nosePoints = CGPoint(x: 0,y: 0)
                
            }
            .customButton()
            //            .onTapGesture {
            //                self.sourceType = .camera
            //                self.isImagePickerDisplay = true
            //                loadImage()
            //                isProccesed = false
            //            }
            
            Button("Library") {
                // isLoaded = false
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
                faceViewModel.nosePoints = CGPoint(x: 0,y: 0)
            }
            .customButton()
            //            .onTapGesture {
            //                self.sourceType = .photoLibrary
            //                self.isImagePickerDisplay.toggle()
            //            }
            //
            
            Button("Add smile") {
                if image != nil {
                    faceViewModel.detectPoints(image: selImg!)
                    isProccesed = true
                }
                else {
                    print("No uploaded photo")
                }
            }
            .customButton()
            //            .onTapGesture {
            //                if image != nil {
            //                    faceViewModel.detectPoints(image: selImg!)
            //                    isProccesed = true
            //                }
            //                else {
            //                    print("No uploaded photo")
            //                }
            //            }
            
            
            Button(isLoaded ? "Save Image Done" : "Save Image" ) {
                //   guard let inputImage = selectedImage else { return }
                
                
                faceViewModel.writeToPhotoAlbum()
                isLoaded = true
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
            .background(isLoaded ? Color.gray : Color.pink)
            .opacity(isProccesed ? 1 : 0)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.horizontal)
            //            .onTapGesture {
            //                guard let inputImage = selectedImage else { return }
            //
            //                faceViewModel.writeToPhotoAlbum(image: faceViewModel.drawImg(selImg!))
            //                isLoaded.toggle()
            //            }
            
            
        }
        .navigationBarTitle("Cartoon Eye")
        .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
        .onChange(of: selectedImage) { _ in
            loadImage()
            isLoaded = false
            isProccesed = false
        }
        
    }
    
    func loadImage() {
        guard let inputImage = selectedImage else { return }
        image = Image(uiImage: inputImage)
        
        
        
        selImg = selectedImage
        // readyImg = faceViewModel.drawImg(selectedImage!)
        // UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
        
    }
    
}
