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
    // 获取电影分类列表
    static func loadMovieDetailData(id: String, completionCallBack:@escaping(_ data:JSON) -> ())
    
    static func loadHomeMovieData(genres: String, completionCallBack:@escaping(_ data:JSON) -> ())
}

extension NetWorkToolProtocol {
    
     //------------Home--------------------------
    static func loadHomeMovieData(genres: String, completionCallBack:@escaping(JSON) -> ()) {
        let url = BASE_URL + "/v2/movie/search"
        //let parameters = ["tag": genres, "start":0,"count": 30]
        print(url)
        Alamofire.request(url, method: .get, parameters: ["tag": genres, "start":0,"count": 30],encoding: URLEncoding.default).responseJSON {
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
