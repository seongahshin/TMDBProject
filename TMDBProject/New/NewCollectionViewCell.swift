//
//  NewCollectionViewCell.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/09.
//

import UIKit

class NewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var NewView: NewView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        NewView.backgroundColor = .clear
        NewView.posterImageView.backgroundColor = .red
        NewView.posterImageView.layer.cornerRadius = 10
    }

}
