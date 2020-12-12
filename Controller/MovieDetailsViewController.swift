//
//  MovieDetailsViewController.swift
//  DarshanaAssignment
//
//  Created by Apple on 09/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import WebKit
class MovieDetailsViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView=UIScrollView()
    var scrollViewCntentSize:CGFloat=0
    var movieId=""
    
    private var apiService=APIService()
    private var genere=[Genre]()
    private var lang=[Language]()
    private var video=[Video]()
    private var movieTitle="",moviewoverview="",releaseDate=""
    var sendDataDelegate:SendDataDelegate?
    
    var navbarHeight:CGFloat=0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navbarHeight=CommonClass.getNavBarHeight(navigationController: self.navigationController!)
        
        
        scrollView = UIScrollView(frame: bottomView.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+480)
        scrollView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        scrollView.isScrollEnabled=true
        scrollView.backgroundColor = .white
        scrollView.isDirectionalLockEnabled = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator=false
        scrollView.showsHorizontalScrollIndicator=false

        
        
        getMovieDetails(completion: {
            DispatchQueue.main.async {
                
                self.getVideo(completion: {
                    DispatchQueue.main.async {

                    self.setup()
                        }
                })
            }
        })
        
    }
    
    func setup(){
        
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: navbarHeight).isActive=true
        webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        webView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive=true
        webView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        webView.backgroundColor=UIColor.black
        webView.translatesAutoresizingMaskIntoConstraints=false
        
        view.addSubview(bottomView)
        bottomView.topAnchor.constraint(equalTo: webView.bottomAnchor).isActive=true
        bottomView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55,constant: -10).isActive=true
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        bottomView.backgroundColor=UIColor.green
        bottomView.translatesAutoresizingMaskIntoConstraints=false
        bottomView.addSubview(scrollView)
        
        scrollView.addSubview(movieTitleLabel)
        movieTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10).isActive=true
        movieTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        movieTitleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        movieTitleLabel.text=movieTitle
        
        
        scrollView.addSubview(synopsisTextView)
        synopsisTextView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor).isActive=true
        synopsisTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        synopsisTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        synopsisTextView.heightAnchor.constraint(equalToConstant: 100).isActive=true
        synopsisTextView.text="\(moviewoverview)"
        
        scrollView.addSubview(releaseDateLabel)
        releaseDateLabel.topAnchor.constraint(equalTo: synopsisTextView.bottomAnchor,constant: 10).isActive=true
        releaseDateLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        releaseDateLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        releaseDateLabel.text="Release Date : \(releaseDate)"
        
        scrollView.addSubview(languageLabel)
        languageLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor,constant: 10).isActive=true
        languageLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        languageLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        languageLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        languageLabel.text="Language : \(lang.first!.englishName!)"
        
        scrollView.addSubview(genreLabel)
        genreLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor,constant: 10).isActive=true
        genreLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        genreLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        genreLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        genreLabel.text="Genre : \(genere.first!.name!)"
        
        scrollView.addSubview(castViewLabel)
        castViewLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor,constant: 15).isActive=true
        castViewLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        castViewLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        castViewLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        
        scrollView.addSubview(castView)
        castView.topAnchor.constraint(equalTo: castViewLabel.bottomAnchor,constant: 10).isActive=true
        castView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        castView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive=true
        castView.heightAnchor.constraint(equalToConstant: 80).isActive=true
        
        scrollView.addSubview(crewLabel)
        crewLabel.topAnchor.constraint(equalTo: castView.bottomAnchor,constant: 100).isActive=true
        crewLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        crewLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        crewLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        
        scrollView.addSubview(crewListView)
        crewListView.topAnchor.constraint(equalTo: crewLabel.bottomAnchor,constant: 10).isActive=true
        crewListView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        crewListView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive=true
        crewListView.heightAnchor.constraint(equalToConstant: 120).isActive=true
        
        scrollView.addSubview(similarMoviesLabel)
        similarMoviesLabel.topAnchor.constraint(equalTo: crewListView.bottomAnchor,constant: 130).isActive=true
        similarMoviesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        similarMoviesLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -20).isActive=true
        similarMoviesLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        
        scrollView.addSubview(similarMoviesView)
        similarMoviesView.topAnchor.constraint(equalTo: similarMoviesLabel.bottomAnchor,constant: 10).isActive=true
        similarMoviesView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive=true
        similarMoviesView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive=true
        similarMoviesView.heightAnchor.constraint(equalToConstant: 180).isActive=true
                
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height:480 + 450)
        
        do{
            if (video.first?.key) != nil {
                            let url = try URL (string:"https://www.youtube.com/embed/\(video.first!.key!)")
                if url != nil{
                    let request = URLRequest(url: url!)
                    webView.load(request)
                    
                }else{
//                    webView.title="Not available"
                    print("URL is not in proper format")
                }
            }else{
                
            }
            
        }catch{
            print(error)
        }
    }
    
    func getMovieDetails(completion : @escaping()->()){
        
        apiService.GetMovieDetails(completion: { (result) in
            switch result{
                
            case .success(let list) :
                self.genere=list.genre
                self.lang=list.lang
                self.movieTitle=list.title!
                self.moviewoverview=list.overview!
                self.releaseDate=list.release_date!
                
                print("success getMovieDetails: \(self.genere)")
                
            case .failure(let err):
                
                print("err getMovieDetails: \(err)")
                completion()
                
            default : break
            }
            completion()
        }, movieId: movieId)
        
    }
    
    func getVideo(completion : @escaping()->()){
        
        apiService.GetVideo(completion: { (result) in
            switch result{
                
            case .success(let list) :
                self.video=list.video
                
                print("success getVideo: \(self.genere)")
                
            case .failure(let err):
                
                print("err getVideo: \(err)")
                completion()
                
            default : break
            }
            completion()
        }, movieId: movieId)
        
    }
    
    let movieTitleLabel : UILabel = {
        
        let lbl=UILabel()
        lbl.text="Title"
        lbl.textAlignment = .left
        lbl.textColor = .orange
        lbl.font=UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        
        return lbl
    }()
    
    let releaseDateLabel : UILabel = {
        
        let lbl=UILabel()
        lbl.text="Release Date"
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        lbl.font=UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let languageLabel : UILabel = {
        
        let lbl=UILabel()
        lbl.text="Language"
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        lbl.font=UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let genreLabel : UILabel = {
        let lbl=UILabel()
        lbl.text="Genre"
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        lbl.font=UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let synopsisTextView : UILabel = {
        let lbl=UILabel()
        lbl.numberOfLines=0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = .lightGray
        lbl.font=UIFont.systemFont(ofSize: 12)
        lbl.text="view.addSubview(synopsisTextView)synopsisTextView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor,constant: 10).isActive=true"
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let webView : WKWebView = {
        let lbl=WKWebView()
        lbl.layer.shadowColor = UIColor.lightGray.cgColor
        lbl.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        lbl.layer.shadowRadius = 2.0
        lbl.layer.shadowOpacity = 1.0
        lbl.layer.cornerRadius=5
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let bottomView : WKWebView = {
        let lbl=WKWebView()
        lbl.layer.shadowColor = UIColor.lightGray.cgColor
        lbl.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        lbl.layer.shadowRadius = 2.0
        lbl.layer.shadowOpacity = 1.0
        lbl.layer.cornerRadius=5
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let castViewLabel : UILabel = {
        let lbl=UILabel()
        lbl.text="Cast"
        lbl.textAlignment = .left
        lbl.textColor = .darkGray
        lbl.font=UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let castView : CastView = {
        let lbl=CastView()
        lbl.layer.shadowColor = UIColor.lightGray.cgColor
        lbl.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        lbl.layer.shadowRadius = 2.0
        lbl.layer.shadowOpacity = 1.0
        lbl.movieId="671583"
        lbl.backgroundColor = .clear
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let similarMoviesLabel : UILabel = {
        let lbl=UILabel()
        lbl.text="Similar Movies"
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font=UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    let similarMoviesView : SimilarMoviesView = {
        let lbl=SimilarMoviesView()
        lbl.layer.shadowColor = UIColor.lightGray.cgColor
        lbl.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        lbl.layer.shadowRadius = 2.0
        lbl.layer.shadowOpacity = 1.0
        lbl.translatesAutoresizingMaskIntoConstraints=false
        lbl.backgroundColor = .clear
        return lbl
    }()
    let crewLabel : UILabel = {
        let lbl=UILabel()
        lbl.text="Crew"
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.font=UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    let crewListView : CrewListView = {
        let lbl=CrewListView()
        lbl.layer.shadowColor = UIColor.lightGray.cgColor
        lbl.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        lbl.layer.shadowRadius = 2.0
        lbl.layer.shadowOpacity = 1.0
        lbl.backgroundColor = .clear
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
}
