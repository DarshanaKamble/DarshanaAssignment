//
//  SimilarMoviesView.swift
//  DarshanaAssignment
//
//  Created by Apple on 10/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class SimilarMoviesView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var movieId=""
    private var apiService=APIService()
    private var similarMovies=[SameData]()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.register(CommonCell.self, forCellWithReuseIdentifier: "commonVCCell")
                
        self.setUpViews()

        getSimilarMovies(completion: {
            
            DispatchQueue.main.async {
                
                self.setUpViews()
            }
        })
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive=true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor,constant: -20).isActive=true
        collectionView.heightAnchor.constraint(equalToConstant: 180).isActive=true
        
    }
    func getSimilarMovies(completion : @escaping()->()){
        
        apiService.GetSimilarMovie(completion: { (result) in
            switch result{
                
            case .success(let list) :
                self.similarMovies=list.movie
                
            case .failure(let err):
                
                print("err : \(err)")
                completion()
                
            default : break
            }
            completion()
        }, movieId: movieId)
    }
    
    let collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.scrollDirection = .horizontal
        
        let myCollectionView=UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator=false
        myCollectionView.allowsMultipleSelection=false
        myCollectionView.backgroundColor = .clear
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        return myCollectionView
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "commonVCCell", for: indexPath)as! CommonCell
        cell.backgroundColor = .white
        cell.castNameLabel.text! = "\(self.similarMovies[indexPath.row].title!)"

        if self.similarMovies[indexPath.row].posterImage != nil{
            cell.posterImageView.downloaded(from: "https://image.tmdb.org/t/p/w500/\(self.similarMovies[indexPath.row].posterImage!)")
        }else{
            cell.posterImageView.image=UIImage(named: "profile_blank_m")
            }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3 + 10
        let height : CGFloat = self.collectionView.frame.height-20
        
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
