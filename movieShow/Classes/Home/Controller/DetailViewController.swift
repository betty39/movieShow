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
    var detail = MovieListTitle()
    @IBOutlet weak var movieNameText1: UILabel!
    @IBOutlet weak var ratingView1: UIView!
    @IBOutlet weak var yearText1: UILabel!
    @IBOutlet weak var collectBtn1: UIButton!
    var sqlmannager:SQLiteManager!
    var username:String = ""
    
    @IBOutlet weak var descText1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = detail.moviename
        movieNameText1.text = detail.moviename
        imageVIew1.kf.setImage(with: URL(string:detail.picture))
        let userDefault = UserDefaults.standard
        username = userDefault.string(forKey: "username")!
        let jsonStr = "{\"id\":24,\"username\":\""+username+"\",\"movieid\":\""+detail.movieid + "\",\"title\":\""+"" + "\",\"year\":\""+""+"\",\"imgmedium\":\"" + ""+"\"}"
        let model = MovieLike.deserialize(from: jsonStr)!
        sqlmannager = SQLiteManager()
        let ifLike = sqlmannager.existmov(model)
        if (ifLike) {
            collectBtn1.setTitle("已收藏", for: .normal)
        }
        yearText1.text = "正在获取～"
        descText1.text = "正在获取～"
        getMovieDetail(id:detail.movieid)
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
    //点击收藏
    @IBAction func collectmov(_ sender: Any) {
        //let userDefault = UserDefaults.standard
        //let username:String = userDefault.string(forKey: "username")!
        let movieid:String = detail.movieid
        let title:String = detail.moviename
        let year:String = self.yearText1.text!
        let imgmedium:String = detail.picture
        
        let jsonStr = "{\"id\":24,\"username\":\""+username+"\",\"movieid\":\""+movieid + "\",\"title\":\""+title + "\",\"year\":\""+year+"\",\"imgmedium\":\"" + imgmedium+"\"}"
        guard let model = MovieLike.deserialize(from: jsonStr) else {return}
        sqlmannager = SQLiteManager()
        sqlmannager.insertmov(model)
        let alert = UIAlertController(title: "电影", message: "收藏成功", preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        collectBtn1.setTitle("已收藏", for: .normal)
    }
    //处理评分
    func transAverage(average:Double) -> String {
        return String(format: "%.1f", average/2)
    }
}
