//
//  NewView.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/09.
//

import UIKit

class NewView: UIView {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    func loadView() {
        let view = UINib(nibName: "NewView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.backgroundColor = .red
        view.layer.contents = 20
        self.addSubview(view)
    }
    

}
