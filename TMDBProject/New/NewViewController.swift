//
//  NewViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/09.
//

import UIKit

import Kingfisher

class NewViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    let color: [UIColor] = [.red, .systemPink, .white, .yellow, .black]
//    let numberList: [[Int]] = [
//        [Int](100...110),
//        [Int](55...75),
//        [Int](5000...5006),
//        [Int](61...70),
//        [Int](71...80),
//        [Int](81...90)
//    ]
    var posterList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        TMDBAPIManager.shared.requestImage(completionHandler: { value in
            dump(value)
            self.posterList = value
            self.mainTableView.reloadData()
        })
        
    }
}

extension NewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posterList.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell", for: indexPath) as? NewTableViewCell else { return UITableViewCell() }
        cell.titleLabel.backgroundColor = .yellow
        cell.contentCollectionView.backgroundColor = .blue
        cell.contentCollectionView.tag = indexPath.section
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.register(UINib(nibName: "NewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCollectionViewCell")
        cell.titleLabel.text = "\(TMDBAPIManager.shared.tvList[indexPath.section].0) 추천 영화"
        cell.contentCollectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

extension NewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posterList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCell", for: indexPath) as? NewCollectionViewCell else { return UICollectionViewCell() }
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(posterList[collectionView.tag][indexPath.item])")
//        cell.NewView.posterImageView.backgroundColor = .black
        cell.NewView.posterImageView.kf.setImage(with: url)
        
        cell.NewView.titleLabel.textColor = .white
        return cell
    }
    
}

