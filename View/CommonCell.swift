//
//  CommonCell.swift
//  DarshanaAssignment
//
//  Created by Apple on 10/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class CommonCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        addSubview(posterImageView)
        posterImageView.topAnchor.constraint(equalTo: topAnchor,constant: 10).isActive=true
        posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        posterImageView.widthAnchor.constraint(equalToConstant: 100).isActive=true
        posterImageView.heightAnchor.constraint(equalToConstant: 100).isActive=true
        
        addSubview(castNameLabel)
        castNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor,constant: 5).isActive=true
        castNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        castNameLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -10).isActive=true
        castNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive=true
        
        
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    let posterImageView : UIImageView = {
        
        let lbl=UIImageView()
        lbl.contentMode = .scaleAspectFit
        lbl.image=UIImage(named: "profile_blank_m")
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let castNameLabel : UILabel = {
        
        let lbl=UILabel()
        lbl.text="Title"
        lbl.textAlignment = .center
        lbl.textColor = .orange
        lbl.font=UIFont.boldSystemFont(ofSize: 12)
        lbl.numberOfLines=0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
}
