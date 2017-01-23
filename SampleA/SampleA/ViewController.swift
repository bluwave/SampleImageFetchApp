//
//  ViewController.swift
//  SampleA
//
//  Created by Garrett Richards on 12/15/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let apiClient = APIClient()
    var images = [SearchAPIImage]()
    @IBOutlet var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureCollectionView()
        configureAPIClient()
    }
    
    func configureAPIClient() {
        apiClient.searchForImages(searchText: "dog") { [weak self] (images, error) in
            self?.processImagesFromAPI(images: images)
        }
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: self)
        self.view.addSubview(searchController.searchBar)
    }
    
    func configureCollectionView() {
//        collectionView.register(SearchImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell") //  FIXME: - use constant
    }
    
    func processImagesFromAPI(images: [SearchAPIImage]?) {
        self.images = images ?? []
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchImageCollectionViewCell
        cell.setupImage(image: images[indexPath.item])
        return cell
    }
}
