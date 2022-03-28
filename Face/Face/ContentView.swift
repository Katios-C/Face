import SwiftUI

struct ContentView: View {

    @ObservedObject private var faceViewModel = FaceViewModel()

    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var isProccesed = false



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
                    if image != nil {
                    faceViewModel.fetectPoints(image: inputImage!)
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



//import SwiftUI
//
//struct ContentView: View {
//
//    @State private var sourceType: UIImagePickerController.SourceType = .camera
//    @State private var selectedImage: UIImage?
//    @State private var isImagePickerDisplay = false
//
//    @ObservedObject private var faceViewModel = FaceViewModel()
//    @State private var image: Image?
//   // @State private var inputImage: UIImage?
//    @State private var isProccesed = false
//
//    var body: some View {
//      //  NavigationView {
//            VStack {
//
//
//                isProccesed ?
//                        VStack {
//                            Image(uiImage: faceViewModel.drawImg(selectedImage!))
//                                .resizable()
//                                .scaledToFit()
//
//
//                        }
//
//                        :
//                        VStack {
//                            image?
//                                .resizable()
//                                .scaledToFit()
//
//                        }
//
//
//
////                if selectedImage != nil {
////
////
////                    ZStack {
////                    Image(uiImage: selectedImage!)
////                        .resizable()
////                        .aspectRatio(contentMode: .fit)
////                        //.clipShape(Circle())
////                        .frame(width: 300, height: 300)
////                      //  .opacity(isProccesed ? 0 : 10)
////                        .onAppear{
////                           // faceViewModel.fetectPoints(image: selectedImage!)
////                        }
////
////
////
////                        if selectedImage != nil && isProccesed {
////                        Image(uiImage: faceViewModel.drawImg(selectedImage!))
////                                           .resizable()
////                                           .scaledToFit()
////                                           .onAppear{
////                                             print("inputImage is here")
////                                           }
////                        }
////
////                    }
////
////                } else {
////
////
////
////                    Rectangle()
////                        .foregroundColor(.gray)
//////                    Image(systemName: "snow")
//////                        .resizable()
//////                        .aspectRatio(contentMode: .fit)
////                       // .clipShape(Circle())
////                        .frame(width: 300, height: 300)
////
////
////
////                }
//
//                Button("Camera") {
//
//                  //  self.sourceType = .camera
//                    self.isImagePickerDisplay = true
//                    loadImage()
//
//                }
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(20)
//                .padding(.horizontal)
//                .onTapGesture {
//                    self.sourceType = .camera
//                    self.isImagePickerDisplay = true
//                }
//
////                Button("photo") {
////                    self.sourceType = .photoLibrary
////                    self.isImagePickerDisplay.toggle()
////                }.padding()
//
//
//                Button("Add smile") {
//                    print("ADD SMILE")
//                                   if image != nil {
//                                   faceViewModel.fetectPoints(image: selectedImage!)
//                                       isProccesed.toggle()
//                                   }
//                                   else {
//                                       print("No uploaded photo")
//                                   }
//                               }
//                               .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
//                               .background(Color.blue)
//                               .foregroundColor(.white)
//                               .cornerRadius(20)
//                               .padding(.horizontal)
//
//
//            }
//            .navigationBarTitle("Cartoon Eye")
//            .sheet(isPresented: self.$isImagePickerDisplay) {
//                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
//            }
//            .onChange(of: selectedImage) { _ in
//                      loadImage()}
//    }
//
//        func loadImage() {
//            guard let inputImage = selectedImage else { return }
//            image = Image(uiImage: inputImage)
//
//        }
//}
