//
//  NetWorkTool.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/14.
//  Copyright © 2018 heyijia All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetWorkToolProtocol {
    //------------Home--------------------------
    // 获取电影按分类列表
    static func loadHomeMovieData(genres: String, completionCallBack:@escaping(_ data:[MovieListTitle]) -> ())
    // 获取电影详情信息
    static func loadMovieDetailData(id: String, completionCallBack:@escaping(_ data:JSON) -> ())
    
    // 获取电影的模糊search
    static func loadMovieSearchData(tag: String, completionCallBack:@escaping(_ data:[MovieListTitle]) -> ())
    
}

extension NetWorkToolProtocol {
    
     //------------Home--------------------------
    static func loadHomeMovieData(genres: String, completionCallBack:@escaping([MovieListTitle]) -> ()) {
        let url = "https://movie.douban.com/j/search_subjects"
        Alamofire.request(url, method: .get, parameters: ["type": "movie", "tag": genres, "sort": "recommend", "page_start":0,"page_limit": 40],encoding: URLEncoding.default).responseJSON {
            response in
            guard response.result.isSuccess else {
                //网络错误提示
                print("网络错误")
                return
            }
            var data:JSON = []
            var movies = [MovieListTitle]()
            data = JSON(response.result.value!)["subjects"]
            for (_,v) in data {
                let if_new = v["is_new"].bool == true ? "新上映" : ""
                let value = "{\"moviename\": \"" + v["title"].string! +  "\", \"movieid\": \"" + v["id"].string! +  "\", \"showyear\": \"" + if_new + "\", \"rate\": \"" + v["rate"].string! + "\", \"picture\": \"" + v["cover"].string! + "\"}"
                movies.append(MovieListTitle.deserialize(from: value)!)
            }
            completionCallBack(movies)
        }
    }
    
    static func loadMovieDetailData(id: String, completionCallBack:@escaping(JSON) -> ()) {
        let url = BASE_URL + "/v2/movie/subject/\(id)"
        print(url)
        Alamofire.request(url, method: .get).responseJSON {
            response in
            guard response.result.isSuccess else {
                //网络错误提示
                print("网络错误")
                return
            }
            var data:JSON = []
            data = JSON(response.result.value)
            completionCallBack(data)
        }
    }
    
    static func loadMovieSearchData(tag: String, completionCallBack:@escaping([MovieListTitle]) -> ()) {
        let url = "https://api.douban.com/v2/movie/search"
        Alamofire.request(url, method: .get, parameters: ["tag":tag,"start":0,"count":10],encoding: URLEncoding.default).responseJSON {
            response in
            guard response.result.isSuccess else {
                //网络错误提示
                print("网络错误")
                return
            }
            var data:JSON = []
            var movies = [MovieListTitle]()
            data = JSON(response.result.value)["subjects"]
            for (_,v) in data {
                let if_new = ""
                let value = "{\"moviename\": \"" + v["title"].string! +  "\", \"movieid\": \"" + v["id"].string! +  "\", \"showyear\": \"" + if_new + "\", \"rate\": \"" + "" + "\", \"picture\": \"" + v["images"]["medium"].string! + "\"}"
                movies.append(MovieListTitle.deserialize(from: value)!)
            }
            completionCallBack(movies)
        }
    }
     //------------Mine------------------------------------
    
}

struct NetWorkTool: NetWorkToolProtocol {
   
}
