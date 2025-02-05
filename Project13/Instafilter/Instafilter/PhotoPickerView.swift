//
//  PhotoPickerView.swift
//  Instafilter
//
//  Created by Tan Xin Jie on 5/2/25.
//

import SwiftUI

import PhotosUI
import SwiftUI

import StoreKit

struct PhotoPickerView: View {
    @State private var pickerItem: PhotosPickerItem?
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImage: Image?
    @State private var selectedImages = [Image]()
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        VStack {
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            selectedImage?
                .resizable()
                .scaledToFit()
            PhotosPicker("Select images", selection: $pickerItems, maxSelectionCount: 3, matching: .images)
            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
            if let selectedImage {
                ShareLink(item: selectedImage, preview: SharePreview("My Picture", image: selectedImage)) {
                    Label("Click to share", systemImage: "airplane")
                }
            }
            ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
                Label("Spread the word about Swift", systemImage: "swift")
            }
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()

                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    PhotoPickerView()
}
