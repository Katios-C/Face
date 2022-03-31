import SwiftUI

struct ContentView: View {

    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false

    @ObservedObject private var faceViewModel = FaceViewModel()
    @State private var image: Image?
    @State private var selImg: UIImage?
    @State private var isProccesed = false

    var body: some View {
      //  NavigationView {
            VStack {
                isProccesed ?
                        VStack {
                            Image(uiImage: faceViewModel.drawImg(selImg!))
                                .resizable()
                                .scaledToFit()
                              
                        }
                
                        :
                        VStack {
                            image?
                                .resizable()
                                .scaledToFit()
                        }


                Button("Camera") {

                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                    loadImage()
                    isProccesed = false

                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
                .onTapGesture {
                    self.sourceType = .camera
                    self.isImagePickerDisplay = true
                }

                Button("photo") {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }.padding()


                Button("Add smile") {
                    print("ADD SMILE")
                                   if image != nil {
                                   faceViewModel.detectPoints(image: selImg!)
                                       isProccesed = true
                                   }
                                   else {
                                       print("No uploaded photo")
                                   }
                               }
                               .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                               .background(Color.blue)
                               .foregroundColor(.white)
                               .cornerRadius(20)
                               .padding(.horizontal)
            }
            .navigationBarTitle("Cartoon Eye")
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            .onChange(of: selectedImage) { _ in
                      loadImage()}
    }

        func loadImage() {
            guard let inputImage = selectedImage else { return }
            image = Image(uiImage: inputImage)
            selImg = selectedImage

        }
}
