//
//  ImagesView.swift
//  AlaaElrhman.Bosta
//
//  Created by AlaaElrhman on 27/04/2022.
//

import UIKit
import RxSwift

class ImagesView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel:ImagesViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerNibs()
        initViewModel()
    }
    
    func setupUI(){
        collectionView.collectionViewLayout = ImagesCollectionViewLayout.generateCollectionViewLayout()
        searchBar.delegate = self
    }
    
    func registerNibs(){
        self.collectionView.register(UINib(nibName: ImagesCVCell.cellID, bundle: nil),
                                     forCellWithReuseIdentifier: ImagesCVCell.cellID)
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
        subscribeToImagesesponse()
        subscribeToTitleName()
        bindSearchBar()
    }
    
    private
    func subscribeToImagesesponse() {
        collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        viewModel.imagesBehavior
            .bind(to: collectionView.rx.items(cellIdentifier: ImagesCVCell.cellID,
                           cellType: ImagesCVCell.self)) { index, image, cell in
                cell.image = image
        }.disposed(by: disposeBag)
    }
    
    private
    func subscribeToTitleName() {
        viewModel.galleryNameBehavior.subscribe(onNext: { [weak self] (name) in
            guard let self = self else { return }
            self.title = name
        }).disposed(by: disposeBag)
    }
    
    private func bindSearchBar(){
        searchBar.rx.text
           .orEmpty
           .subscribe(onNext: {query in
               self.viewModel.filterWith(name: query)
           })
           .disposed(by: disposeBag)
    }
    
}
//MARK: - instance -
extension ImagesView{
    static func instantiate() -> ImagesView? {
        let sb = UIStoryboard(name: "ImagesView", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ImagesView") as? ImagesView
        return vc
    }
}
extension ImagesView: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
