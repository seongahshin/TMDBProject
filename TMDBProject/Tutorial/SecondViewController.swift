//
//  SecondViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/16.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButtonDesign()
        
    }
    
    func nextButtonDesign() {
        nextButton.setTitle("다음 화면", for: .normal)
        nextButton.backgroundColor = .lightGray
        nextButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MediaCollectionViewController") as! MediaCollectionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
