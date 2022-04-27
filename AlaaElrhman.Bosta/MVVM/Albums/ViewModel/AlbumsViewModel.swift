//
//  AlbumsViewModel.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

struct AlbumsViewModel{
    private var networkApi: NetworkDelegate?
    
    //MARK:- Common
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var errorBehavior = BehaviorRelay<String>(value: "")
    var albumsBehavior = BehaviorRelay<AlbumsResponse>(value: [])
    var nameBehavior = BehaviorSubject<String>(value: "")
    var addressBehavior = BehaviorSubject<String>(value: "")

    init(networkApi:NetworkDelegate){
        self.networkApi = networkApi
        self.getUser()
    }
    
    private func getAlbums(){
        loadingBehavior.accept(true)
        DispatchQueue.global().async {
            self.networkApi?.getAlbums(completion: { albums, error in
                DispatchQueue.main.async {
                    self.loadingBehavior.accept(false)
                    if let albums = albums {
                        self.albumsBehavior.accept(albums)
                    }else if let error = error{
                        self.errorBehavior.accept(error)
                    }
                }
            })
        }
    }
    
    private func getUser(){
        loadingBehavior.accept(true)
        DispatchQueue.global().async {
            self.networkApi?.getUsers(completion: { users, error in
                self.loadingBehavior.accept(false)
                if let users = users {
                    if let pickedUser = users.randomElement(){
                        self.nameBehavior.onNext(pickedUser.username ?? "")
                            
                        let address = pickedUser.address?.street ?? "" + ", \(pickedUser.address?.city ?? "")" + ", \(pickedUser.address?.suite ?? "")"
                        self.addressBehavior.onNext(address)
                           
                        UserDefaults.standard.set(pickedUser.id, forKey: "userId")
                        UserDefaults.standard.synchronize()
                            
                        getAlbums()
                    }else if let error = error{
                        self.errorBehavior.accept(error)
                    }
                }
            })
        }
    }
    
    func getAlbum(at indexPath:IndexPath) -> AlbumsResponseElement?{
        let values = albumsBehavior.value
        return values[indexPath.row]
    }
}
