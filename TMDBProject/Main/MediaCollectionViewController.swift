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
    
   
    var list: [MediaModel] = []
    var OverviewList: [String] = []
    var titleList: [String] = []
    var imageList: [String] = []
    var backdropList: [String] = []
    var movieIDList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
       requestData()
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        print(list.count)
        return list.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as! MediaCollectionViewCell
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(list[indexPath.row].movieImage)")
        
        // 개봉일 디자인
        cell.mediaReleaseDate.font = .systemFont(ofSize: 10)
        cell.mediaReleaseDate.textAlignment = .center
        
        // 이미지 디자인
        cell.mediaImage.kf.setImage(with: url)
        cell.mediaImage.contentMode = .scaleAspectFill
        cell.mediaImage.layer.cornerRadius = 10
        cell.mediaImage.layer.borderWidth = 0.05
        cell.mediaImage.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.3
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.shadowOffset = CGSize(width: -2, height: 2)
        cell.layer.shadowRadius = 3

        
        // 타이틀 디자인
        cell.mediaTitle.text = list[indexPath.row].movieTitle
        cell.mediaTitle.font = .boldSystemFont(ofSize: 16)
        
        // 배우 디자인
        cell.mediaActor.textAlignment = .center
        
        // 버튼 디자인
        cell.detailButton.setTitle("자세히 보기", for: .normal)
        cell.detailButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        cell.detailButton.setTitleColor(.black, for: .normal)
        
        
        // 화살표 버튼 디자인
        cell.arrowButton.tintColor = .darkGray
        
        // 셀 테두리 디자인
        cell.backView.layer.masksToBounds = true
        cell.backView.layer.cornerRadius = 10
        cell.backView.layer.borderWidth = 0.05
        
        
        
        cell.layer.masksToBounds = false
        cell.layer.shadowOpacity = 0.3
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.shadowOffset = CGSize(width: -2, height: 2)
        cell.layer.shadowRadius = 3
       
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: list[indexPath.row].movieDate)
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if let date1 = date {
            let resultString = dateFormatter.string(from: date1)
            cell.mediaReleaseDate.text = resultString
        }
        
        
        return cell

    }
    
    func requestData() {
        let url = EndPoint.TMDBurl + "/trending/movie/day?api_key=\(APIKey.TMDBKey)"

        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
                    case .success(let value):

                        let json = JSON(value)
                        print("JSON: \(json)")

                       
                for num in 0...json["results"].count - 1 {
                    // 이미지
                    let MI = json["results"][num]["poster_path"].stringValue
                    imageList.append(MI)
                    
                    let BI = json["results"][num]["backdrop_path"].stringValue
                    backdropList.append(BI)
                    
                    // 제목
                    let MT = json["results"][num]["title"].stringValue
                    titleList.append(MT)
                    
                    // 배우 (미완)
                    let MD = json["results"][num]["genres"]["name"].stringValue
                    
                    // 개봉일
                    let MR = json["results"][num]["release_date"].stringValue
                    
                    // 장르
                    let MG = json["results"][num]["genre_ids"][0].intValue
                    
                    // 화면전환 - 줄거리
                    let MO = json["results"][num]["overview"].stringValue
                    OverviewList.append(MO)
                    
                    // 화면전환 - ID
                    let MID = json["results"][num]["id"].stringValue
                    movieIDList.append(MID)
                    
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
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.OverviewInfo = OverviewList[indexPath.item]
        vc.titleInfo = titleList[indexPath.item]
        vc.imageInfo = imageList[indexPath.item]
        vc.backdropInfo = backdropList[indexPath.item]
        vc.movieIDINfo = movieIDList[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    
        }
    }



