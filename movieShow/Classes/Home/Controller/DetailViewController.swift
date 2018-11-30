//
//  DetailViewController.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/29.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageVIew1: UIImageView!
    var detail:JSON = []
    @IBOutlet weak var movieNameText1: UILabel!
    @IBOutlet weak var ratingView1: UIView!
    @IBOutlet weak var yearText1: UILabel!
    @IBOutlet weak var collectBtn1: UIButton!
    
    @IBOutlet weak var descText1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        movieNameText1.text = detail["title"].string
        imageVIew1.kf.setImage(with: URL(string:detail["cover"].string!))
 
        yearText1.text = "正在获取～"
        descText1.text = "正在获取～"
        getMovieDetail(id:detail["id"].string!)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getMovieDetail(id:String){
        NetWorkTool.loadMovieDetailData(id: id) { (detail) in
            self.yearText1.text = detail["year"].string! + "年    评分: " + self.transAverage(average: detail["rating"]["average"].double!)
            if let rating = Double(self.transAverage(average: detail["rating"]["average"].double!)) {
                RatingView.showInView(view: self.ratingView1, value:rating)
            }else {
                RatingView.showNORating(view: self.ratingView1)
            }
            self.descText1.text = detail["summary"].string
        }
    }

    //处理评分
    func transAverage(average:Double) -> String {
        return String(format: "%.1f", average/2)
    }
}
