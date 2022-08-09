//
//  NewViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/09.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    let color: [UIColor] = [.red, .systemPink, .white, .yellow, .black]
    let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](61...70),
        [Int](71...80),
        [Int](81...90)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self 
        
    }
}

extension NewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberList.count
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
        cell.contentCollectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 3 ? 350 : 190
    }
}

extension NewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCell", for: indexPath) as? NewCollectionViewCell else { return UICollectionViewCell() }
        cell.NewView.posterImageView.backgroundColor = .black
        cell.NewView.titleLabel.text = "\(numberList[collectionView.tag][indexPath.item])"
        cell.NewView.titleLabel.textColor = .white
        return cell
    }
    
}

