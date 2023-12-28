//
//  CoinImageService.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 16/12/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image:UIImage? = nil
    private var ImageSubscription: AnyCancellable?
    private let coin:Coin
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName:String
    
    init(coin:Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image from File Manager!")
        } else {
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage() {
        print("Downloading image now")
        guard let url = URL(string: coin.image) else { return }
        
        ImageSubscription =  NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
               return UIImage(data: data)
            })
           .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handelCompletion, receiveValue: {
                [weak self] returnImage in
                guard let self = self,let downloadedImage = returnImage else {return}
                self.image = downloadedImage
                self.ImageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
