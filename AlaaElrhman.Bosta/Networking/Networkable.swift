//
//  Networkable.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import Foundation
import Moya

protocol NetworkDelegate{
    var provider: MoyaProvider<Service> { get }
    func getAlbums(completion: @escaping ((AlbumsResponse?, String?) -> ()))
    func getPhotos(albumId:String, completion: @escaping ((ImagesResponse?, String?) -> ()))
    func getUsers(completion: @escaping ((UsersResponse?, String?) -> ()))
}

struct Network:NetworkDelegate{

    var provider: MoyaProvider<Service> = MoyaProvider()
                         
    func getAlbums(completion: @escaping ((AlbumsResponse?, String?) -> ())) {
        provider.request(.albums) { result in
            switch result{
            case .success(let value):
                do{
                    let albums = try JSONDecoder().decode(AlbumsResponse.self, from: value.data)
                    completion(albums, nil)
                }catch{
                    completion(nil,error.localizedDescription)
                }
                break
            case .failure(let error):
                completion(nil,error.localizedDescription)
            }
        }
    }
                         
    func getPhotos(albumId: String, completion: @escaping ((ImagesResponse?, String?) -> ())) {
        provider.request(.photos(albumId: albumId)) { result in
            switch result{
            case .success(let value):
                do{
                    let images = try JSONDecoder().decode(ImagesResponse.self, from: value.data)
                    completion(images, nil)
                }catch{
                    completion(nil,error.localizedDescription)
                }
                break
            case .failure(let error):
                completion(nil,error.localizedDescription)
            }
        }
    }
    
    func getUsers(completion: @escaping ((UsersResponse?, String?) -> ())) {
        provider.request(.users) { result in
            switch result{
            case .success(let value):
                do{
                    let images = try JSONDecoder().decode(UsersResponse.self, from: value.data)
                    completion(images, nil)
                }catch{
                    completion(nil,error.localizedDescription)
                }
                break
            case .failure(let error):
                completion(nil,error.localizedDescription)
            }
        }
    }
}
