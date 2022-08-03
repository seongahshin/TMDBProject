//
//  MediaCollectionViewCell.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/03.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var mediaTitle: UILabel!
    
    @IBOutlet weak var mediaActor: UILabel!
    
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var mediaReleaseDate: UILabel!
    
    @IBOutlet weak var mediaGenre: UILabel!
}
