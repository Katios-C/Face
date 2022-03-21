import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject private var faceViewModel = FaceViewModel()
    
    @State private var image: Image?
    @State private var imageInter: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var isProccesed = false
    // @State private var

    
    var body: some View {
        
        VStack {
            isProccesed ?
            VStack {
                
                Image(uiImage: faceViewModel.drawImg(inputImage!))
                    .resizable()
                    .scaledToFit()
            }
            :
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
            }
            
            HStack {
                Button("Add photo") {
                    loadImage()
                    showingImagePicker = true
                    isProccesed = false
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
                
                
                Button("Add smile") {
                    faceViewModel.fetectPoints(image: inputImage!)
                    isProccesed = true
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .onChange(of: inputImage) { _ in
            loadImage()}
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
            
        }
        
    }
    func loadImage() {
        
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
    }
}
