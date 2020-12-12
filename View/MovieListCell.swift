//
//  MovieListCell.swift
//  DarshanaAssignment
//
//  Created by Apple on 09/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class MovieListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: topAnchor,constant: 10).isActive=true
        movieImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10).isActive=true
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive=true
        movieImageView.heightAnchor.constraint(equalToConstant: 120).isActive=true
        
        addSubview(movieTitleLabel)
        movieTitleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10).isActive=true
        movieTitleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor,constant: 10).isActive=true
//        movieTitleLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -20).isActive=true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        movieTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.7,constant: -10).isActive=true
        
        addSubview(releaseDateLabel)
        releaseDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor,constant: 10).isActive=true
        releaseDateLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor,constant: 10).isActive=true
        releaseDateLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -20).isActive=true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        
        addSubview(otherDetailsLabel)
        otherDetailsLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor,constant: 10).isActive=true
        otherDetailsLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor,constant: 10).isActive=true
//        otherDetailsLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -10).isActive=true
        otherDetailsLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.7,constant: -10).isActive=true
        otherDetailsLabel.heightAnchor.constraint(equalToConstant: 100).isActive=true
        
        addSubview(playBtn)
        playBtn.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 10).isActive=true
        playBtn.leftAnchor.constraint(equalTo: leftAnchor,constant: 10).isActive=true
        playBtn.widthAnchor.constraint(equalToConstant: 80).isActive=true
        playBtn.heightAnchor.constraint(equalToConstant: 40).isActive=true
        
        
        self.contentView.layer.cornerRadius = 1.0
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
    
    let movieTitleLabel : UILabel = {
        
        let lbl=UILabel()
        lbl.text=""
        lbl.textAlignment = .left
        lbl.textColor = .orange
        lbl.numberOfLines=0
        lbl.lineBreakMode = .byWordWrapping
        lbl.font=UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        
        return lbl
    }()
    
    let releaseDateLabel : UILabel = {
        
        let lbl=UILabel()
        lbl.text="06"
        lbl.textAlignment = .left
        lbl.textColor = .darkGray
        lbl.font=UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let otherDetailsLabel : UILabel = {
        
        let lbl=UILabel()
        lbl.text="other Details"
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        lbl.font=UIFont.boldSystemFont(ofSize: 12)
        lbl.numberOfLines=0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let movieImageView : UIImageView = {
        let lbl=UIImageView()
        lbl.contentMode = .scaleAspectFit
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius=20
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let playBtn : UIButton = {
        let lbl=UIButton()
        lbl.setTitle("PLAY", for: .normal)
        lbl.backgroundColor = CommonColor.navBarColor
        lbl.setTitleColor(.white, for: .normal)
        lbl.titleLabel?.font=UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
}
