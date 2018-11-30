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
    // 获取电影详情信息
    static func loadMovieDetailData(id: String, completionCallBack:@escaping(_ data:JSON) -> ())
    // 获取电影按分类列表
    static func loadHomeMovieData(genres: String, completionCallBack:@escaping(_ data:JSON) -> ())
}

extension NetWorkToolProtocol {
    
     //------------Home--------------------------
    static func loadHomeMovieData(genres: String, completionCallBack:@escaping(JSON) -> ()) {
        let url = "https://movie.douban.com/j/search_subjects"
        //let parameters = ["tag": genres, "start":0,"count": 30]
        print(url)
        Alamofire.request(url, method: .get, parameters: ["type": "movie", "tag": genres, "sort": "recommend", "page_start":0,"page_limit": 20],encoding: URLEncoding.default).responseJSON {
            response in
            guard response.result.isSuccess else {
                //网络错误提示
                print("网络错误")
                return
            }
            var data:JSON = []
            data = JSON(response.result.value)["subjects"]
            completionCallBack(data)
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
     //------------Mine------------------------------------
    
}

struct NetWorkTool: NetWorkToolProtocol {
   
}
