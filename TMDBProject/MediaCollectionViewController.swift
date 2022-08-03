//
//  MediaCollectionViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class MediaCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var MediaCollectionView: MediaCollectionViewCell!
    var list: [MediaModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
       requestData()
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        requestData()
        print(list.count)
        return list.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as! MediaCollectionViewCell
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(list[indexPath.row].movieImage)")
        cell.mediaImage.kf.setImage(with: url)
        cell.mediaTitle.text = list[indexPath.row].movieTitle
        cell.mediaActor.text = list[indexPath.row].movieActor
        cell.mediaImage.contentMode = .scaleAspectFill
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: list[indexPath.row].movieDate)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let resultString = dateFormatter.string(from: date!)
        cell.mediaReleaseDate.text = resultString
        
        return cell

    }
    
    func requestData() {


        let url = EndPoint.TMDBurl + "/trending/movie/week?api_key=\(APIKey.TMDBKey)"

        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
                    case .success(let value):

                        let json = JSON(value)
                        print("JSON: \(json)")

                       
                        for num in 0...5 {
                            let MI = json["results"][num]["poster_path"].stringValue
                            print(MI)
                            let MT = json["results"][num]["title"].stringValue
                            let MD = json["results"][num]["overview"].stringValue
                            let MR = json["results"][num]["release_date"].stringValue

                            let data = MediaModel(movieImage: MI, movieTitle: MT, movieActor: MD, movieDate: MR)
                            self.list.append(data)
                        }
                        
                        self.collectionView.reloadData()
                        print(list)
                    



                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }

