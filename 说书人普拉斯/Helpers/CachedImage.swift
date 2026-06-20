//
//  CachedImage.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

import UIKit

class ImageCache {
  static let shared = NSCache<NSString, UIImage>()
}
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
  @Published var image: UIImage?
  private var cancellable: AnyCancellable?
  
  init(urlString: String) {
    loadImage(from: urlString)
  }

  func loadImage(from urlString: String) {
    if let cached = ImageCache.shared.object(forKey: urlString as NSString) {
      self.image = cached
      return
    }
    
    guard let url = URL(string: urlString) else { return }

    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] downloadedImage in
        if let downloadedImage = downloadedImage {
          ImageCache.shared.setObject(downloadedImage, forKey: urlString as NSString)
        }
        self?.image = downloadedImage
      }
  }
//  func loadImage(from urlString: String) {
//    guard let url = URL(string: urlString) else { return }
//
//    var request = URLRequest(url: url)
//    request.setValue(
//      "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1",
//      forHTTPHeaderField: "User-Agent"
//    )
//    request.setValue("image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8",
//                     forHTTPHeaderField: "Accept")
//
//    cancellable = URLSession.shared.dataTaskPublisher(for: request)
//      .tryMap { output -> UIImage? in
//        if let response = output.response as? HTTPURLResponse {
//          print("status:", response.statusCode)
//          print("content-type:", response.value(forHTTPHeaderField: "Content-Type") ?? "nil")
//        }
//
//        let image = UIImage(data: output.data)
//        print("data size:", output.data.count, "image nil?", image == nil)
//        return image
//      }
//      .receive(on: DispatchQueue.main)
//      .sink(
//        receiveCompletion: { completion in
//          print("completion:", completion)
//        },
//        receiveValue: { [weak self] downloadedImage in
//          if let downloadedImage = downloadedImage {
//            ImageCache.shared.setObject(downloadedImage, forKey: urlString as NSString)
//          }
//          self?.image = downloadedImage
//        }
//      )
//  }
  
  func cancel() {
    cancellable?.cancel()
  }
}


struct CachedImageView: View {
  @ObservedObject private var loader: ImageLoader
  var placeholder: Image

  init(urlString: String, placeholder: Image = Image(systemName: "questionmark.circle")) {
    self.loader = ImageLoader(urlString: urlString)
    self.placeholder = placeholder
  }

  var body: some View {
    Group {
      if let uiImage = loader.image {
        Image(uiImage: uiImage)
          .resizable()
      } else {
        placeholder
          .resizable()
      }
    }
  }
}

