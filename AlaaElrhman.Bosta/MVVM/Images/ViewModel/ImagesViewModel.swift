//
//  ImagesViewModel.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

struct ImagesViewModel{
    private var networkApi: NetworkDelegate?
    
    //MARK:- Common
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var errorBehavior = BehaviorRelay<String>(value: "")
    var imagesBehavior = BehaviorRelay<ImagesResponse>(value: [])
    private var allImages = BehaviorRelay<ImagesResponse>(value: [])
    var galleryNameBehavior = BehaviorRelay<String>(value: "")
    
    init(networkApi:NetworkDelegate, album:AlbumsResponseElement){
        self.networkApi = networkApi
        if let id = album.id {
            self.getImages(albumId: "\(id)")
        }
        galleryNameBehavior.accept(album.title ?? "")
    }
    
    private func getImages(albumId:String){
        self.loadingBehavior.accept(true)
        DispatchQueue.global().async {
            self.networkApi?.getPhotos(albumId: albumId){ images, error in
                DispatchQueue.main.async {
                    self.loadingBehavior.accept(false)
                    if let images = images {
                        self.allImages.accept(images)
                        self.imagesBehavior.accept(images)
                    }else if let error = error{
                        self.errorBehavior.accept(error)
                    }

                }
            }
        }
    }
    
    func filterWith(name:String){
        if name == ""{
            self.imagesBehavior.accept(allImages.value)
        }else{
            let filterd = allImages.value.filter({$0.title?.contains(name) == true})
            self.imagesBehavior.accept(filterd)
        }
    }
}
