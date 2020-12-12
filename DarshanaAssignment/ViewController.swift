//
//  ViewController.swift
//  DarshanaAssignment
//
//  Created by Apple on 09/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate  {
    
    
    
    private var apiService=APIService()
    private var movies=[Movie]()
    var currentSearchMovies=[Movie]()
    var navbarHeight:CGFloat=0.0
    var cmncls=CommonClass()
//    var sendDataDelegate:SendDataDelegate?
    var movieID=""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        collectionView.delegate=self
        collectionView.dataSource=self
        searchBar.delegate=self
        
        navbarHeight=CommonClass.getNavBarHeight(navigationController: self.navigationController!)

        getPopularMovies(completion: {
            
            DispatchQueue.main.async {
                
                self.setUpViews()
            }
        })
    }
    
    func dataPassing(movieId: String) {
        movieID=movieId
    }
    
    func setUpViews(){
        
        view.addSubview(searchBar)
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -20).isActive=true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive=true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: navbarHeight + 10).isActive=true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 10).isActive=true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor,constant: -100).isActive=true
    }
    
    let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.showsSearchResultsButton=true
        search.translatesAutoresizingMaskIntoConstraints=false
        search.barTintColor = UIColor(red: 172/255, green: 153/255, blue: 231/255, alpha: 1)
        search.searchTextField.backgroundColor = .white
        search.resignFirstResponder()
        return search
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentSearchMovies.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "movieVCCell", for: indexPath)as! MovieListCell
        cell.backgroundColor = .white
        cell.playBtn.tag=indexPath.row
        
        cell.movieTitleLabel.text! = "\(currentSearchMovies[indexPath.row].title!)"
        cell.releaseDateLabel.text! = "Release Date : \(currentSearchMovies[indexPath.row].year!)"
        cell.otherDetailsLabel.text! = "\(currentSearchMovies[indexPath.row].overview!)"
       
        movieID="\(currentSearchMovies[indexPath.row].id!)"
        cell.playBtn.addTarget(self, action: #selector(handlePlay(sender:)), for: .touchUpInside)
        
        cell.movieImageView.downloaded(from: "https://image.tmdb.org/t/p/w500/\(self.movies[indexPath.row].posterImage!)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        let height : CGFloat = 190
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
//        CommonClass.selectedMovieID="\(currentSearchMovies[indexPath.row].id!)"
//
//
//        sendDataDelegate?.dataPassing(movieId: "\(currentSearchMovies[indexPath.row].id!)")
//
//        let nextVc=MovieDetailsViewController()
//        nextVc.movieId="\(movies[indexPath.row].id!)"
//        self.navigationController?.pushViewController(nextVc, animated: true)

    }
    let collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        let myCollectionView=UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator=false
        myCollectionView.allowsMultipleSelection=false
        myCollectionView.backgroundColor = .white
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        myCollectionView.register(MovieListCell.self, forCellWithReuseIdentifier: "movieVCCell")
        return myCollectionView
    }()
    
    @objc func handlePlay(sender:UIButton){
        CommonClass.selectedMovieID="\(currentSearchMovies[sender.tag].id!)"
                
        let nextVc=MovieDetailsViewController()
        self.navigationController?.pushViewController(nextVc, animated: true)
    }

    
    func getPopularMovies(completion : @escaping()->()){
        
        apiService.GetPopular { (result) in
            
            switch result{
                
            case .success(let list) :
                self.movies=list.movie
                self.currentSearchMovies=self.movies
                
            case .failure(let err):
                
                print("err : \(err)")
                completion()
                
            default : break
            }
            completion()
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            self.currentSearchMovies=self.movies
            collectionView.reloadData()
            return
        }
            self.currentSearchMovies=self.movies.filter({ movie -> Bool in
            guard let text=searchBar.text else{return false}
                return movie.title!.contains(text)
            
        })
        collectionView.reloadData()
    }
    
}

