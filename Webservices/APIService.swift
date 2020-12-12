//
//  APIService.swift
//  DarshanaAssignment
//
//  Created by Apple on 09/12/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
class APIService {
    
    private var dataTask : URLSessionDataTask?
    
    func GetPopular(completion : @escaping (Result<MoviesData,Error>)->Void){
        
        let url="https://api.themoviedb.org/3/movie/now_playing?api_key=9e2bdab1d9b5dc661e6ca6cc3d0fabff&language=en-US&page=1"
        //"https://api.themoviedb.org/3/movie/popular?api_key=9e2bdab1d9b5dc661e6ca6cc3d0fabff&language=en-US&page=1"
        
        guard let movieUrl=URL(string: url)else{
            return
        }
        
        dataTask=URLSession.shared.dataTask(with: movieUrl){(data,response,error) in
            
            guard let resp=response as? HTTPURLResponse else{
                return
            }
            
            do{
                let decoder=JSONDecoder()
                let movie = try decoder.decode(MoviesData.self, from: data!)
                
                print("Movie : \(movie)")
                DispatchQueue.main.async {
                    completion(.success(movie))
                }
                
            }catch let error{
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
    }
    
    func GetMovieDetails(completion : @escaping (Result<MoviesDetails,Error>)->Void,movieId:String){
        
        let url="https://api.themoviedb.org/3/movie/\(CommonClass.selectedMovieID!)?api_key=9e2bdab1d9b5dc661e6ca6cc3d0fabff&language=en-US"
        
        guard let movieUrl=URL(string: url)else{
            return
        }
        
        dataTask=URLSession.shared.dataTask(with: movieUrl){(data,response,error) in
            
            guard let resp=response as? HTTPURLResponse else{
                return
            }
            
            do{
                let decoder=JSONDecoder()
                let movie = try decoder.decode(MoviesDetails.self, from: data!)
                
                print("Movie Details: \(movie)")
                
                DispatchQueue.main.async {
                    completion(.success(movie))
                }
                
            }catch let error{
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
    }
    
    func GetMovieCredits(completion : @escaping (Result<CastData,Error>)->Void,movieId:String){
        
        let url="https://api.themoviedb.org/3/movie/\(CommonClass.selectedMovieID!)/credits?api_key=9e2bdab1d9b5dc661e6ca6cc3d0fabff&language=en-US"
        
        guard let movieUrl=URL(string: url)else{
            return
        }
        
        dataTask=URLSession.shared.dataTask(with: movieUrl){(data,response,error) in
            
            guard let resp=response as? HTTPURLResponse else{
                return
            }
            
            do{
                let decoder=JSONDecoder()
                let movie = try decoder.decode(CastData.self, from: data!)
                
                print("Movie Credits: \(movie)")
                
                DispatchQueue.main.async {
                    completion(.success(movie))
                }
                
            }catch let error{
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
    }
    
    func GetSimilarMovie(completion : @escaping (Result<SimilarData,Error>)->Void,movieId:String){
        
        let url="https://api.themoviedb.org/3/movie/\(CommonClass.selectedMovieID!)/similar?api_key=9e2bdab1d9b5dc661e6ca6cc3d0fabff&language=en-US&page=1"
        
        guard let movieUrl=URL(string: url)else{
            return
        }
        
        dataTask=URLSession.shared.dataTask(with: movieUrl){(data,response,error) in
            
            guard let resp=response as? HTTPURLResponse else{
                return
            }
            
            do{
                let decoder=JSONDecoder()
                let movie = try decoder.decode(SimilarData.self, from: data!)
                
                print("Similar Movies: \(movie)")
                
                DispatchQueue.main.async {
                    completion(.success(movie))
                }
                
            }catch let error{
                completion(.failure(error))
                
                print("Similar Movies error : \(error)")
            }
            
        }
        dataTask?.resume()
        
    }
    
    func GetVideo(completion : @escaping (Result<VideoData,Error>)->Void,movieId:String){

        let url="https://api.themoviedb.org/3/movie/\(CommonClass.selectedMovieID!)/videos?api_key=9e2bdab1d9b5dc661e6ca6cc3d0fabff&language=en-US"

        guard let movieUrl=URL(string: url)else{
            return
        }

        dataTask=URLSession.shared.dataTask(with: movieUrl){(data,response,error) in

            guard let resp=response as? HTTPURLResponse else{
                return
            }

            do{
                let decoder=JSONDecoder()
                let movie = try decoder.decode(VideoData.self, from: data!)

                print("Get Movies: \(movie)")

                DispatchQueue.main.async {
                    completion(.success(movie))
                }

            }catch let error{
                completion(.failure(error))

                print("Similar Movies error : \(error)")
            }

        }
        dataTask?.resume()

    }
    
    
}
