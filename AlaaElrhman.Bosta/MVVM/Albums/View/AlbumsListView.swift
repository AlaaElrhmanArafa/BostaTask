//
//  AlbumsListView.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import UIKit
import RxSwift

class AlbumsListView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var viewModel:AlbumsViewModel = AlbumsViewModel(networkApi: Network())
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        initViewModel()
    }
    
    private func registerNibs(){
        tableView.register(UINib(nibName: AlbumsListTVCell.cellID, bundle: nil), forCellReuseIdentifier: AlbumsListTVCell.cellID)
    }
    
    private func subscribeToLoading() {
        viewModel.loadingBehavior.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else {return}
            if isLoading {
                self.startAnimate()
            }else{
                self.stopAnimate()
            }
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToError() {
        viewModel.errorBehavior.subscribe(onNext: { [weak self] (error) in
            guard let self = self else { return }
            if error != ""{
                self.alertError(message: error)
            }
        }).disposed(by: disposeBag)
    }
    
    private func initViewModel(){
        subscribeToLoading()
        subscribeToError()
        subscribeToAlbumsResponse()
        susbscribeToSelecedAlbums()
        viewModel.nameBehavior.bind(to: lblName.rx.text).disposed(by: disposeBag)
        viewModel.addressBehavior.bind(to: lblAddress.rx.text).disposed(by: disposeBag)
    }
    
    private
    func subscribeToAlbumsResponse() {
        tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        viewModel.albumsBehavior
            .bind(to: tableView.rx.items(cellIdentifier: AlbumsListTVCell.cellID,
                           cellType: AlbumsListTVCell.self)) { index, album, cell in
                cell.album = album
        }.disposed(by: disposeBag)
    }
    
    private func susbscribeToSelecedAlbums(){
        tableView.rx.itemSelected.subscribe(onNext:{ [weak self] indexPath in
            guard let self = self else { return }
            if let vc = ImagesView.instantiate(), let album = self.viewModel.getAlbum(at: indexPath){
                vc.viewModel = ImagesViewModel(networkApi: Network(), album: album)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
extension AlbumsListView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
