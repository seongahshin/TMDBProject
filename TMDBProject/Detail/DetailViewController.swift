//
//  DetailViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/04.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var OverviewInfo = ""
    var titleInfo = ""
    var imageInfo = ""
    var backdropInfo = ""
    var movieIDINfo = ""
    var list: [String] = []
    var chrList: [CharacterModel] = []
    var totalCount = 0
    var startPage = 3
    
    @IBOutlet weak var OverviewTableView: UITableView!
    @IBOutlet weak var CastTableView: UITableView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailPoster: UIImageView!
    @IBOutlet weak var detailBackDrop: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OverviewTableView.delegate = self
        OverviewTableView.dataSource = self
        CastTableView.delegate = self
        CastTableView.dataSource = self
        headerDesign()
        self.navigationItem.title = "출연/제작"
//        CastTableView.prefetchDataSource = self
        requestData()
    }
    
    func headerDesign() {
        let posterURL = URL(string: "https://image.tmdb.org/t/p/original/\(imageInfo)")
        detailPoster.kf.setImage(with: posterURL)
        detailTitle.text = titleInfo
        
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/original/\(backdropInfo)")
        detailBackDrop.kf.setImage(with: backdropURL)
        
        // 헤더 제목 디자인
        detailTitle.textColor = .white
        detailTitle.font = .boldSystemFont(ofSize: 30)
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case OverviewTableView:
            return "Overview"
        default:
            return "Cast"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case OverviewTableView:
            return 1
        default:
            return chrList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case OverviewTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! OverviewTableViewCell
            cell.overviewLable.text = OverviewInfo
            cell.overviewLable.font = .boldSystemFont(ofSize: 14)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
            
            // 셀 이미지
            let url = URL(string: "https://image.tmdb.org/t/p/original/\(chrList[indexPath.row].chrImage)")
            cell.chrImage.kf.setImage(with: url)
            
            // 셀 본명
            cell.chrRealName.text = chrList[indexPath.row].chrRealName
            
            cell.chrRealName.font = .boldSystemFont(ofSize: 20)
            
            // 셀 캐릭터명
            cell.chrName.text = chrList[indexPath.row].chrName
            cell.chrName.textColor = .lightGray
            cell.chrName.font = .systemFont(ofSize: 14)
            return cell
        }
    }
    
    func requestData() {
        let url = EndPoint.TMDBcastURL + "\(movieIDINfo)/credits?api_key=\(APIKey.TMDBKey)&language=en-US\(startPage)"
        

        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
                    case .success(let value):

                        let json = JSON(value)
                        print("JSON: \(json)")

                for num in 0...json["cast"].count - 1 {
                
                    // 캐릭터 이미지
                    let CharaterImage = json["cast"][num]["profile_path"].stringValue

                    // 캐릭터 본명
                    let CharacterRealName = json["cast"][num]["original_name"].stringValue

                    // 캐릭터명
                    let CharacterName = json["cast"][num]["character"].stringValue
                    let data = CharacterModel(chrImage: CharaterImage, chrRealName: CharacterRealName, chrName: CharacterName)
                    self.chrList.append(data)
                }
                self.CastTableView.reloadData()
                    
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    
    
    

}

//extension DetailViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            if chrList.count - 1 == indexPath.item && chrList.count < totalCount {
//                startPage += 4
//            }
//        }
//    }
    
    

