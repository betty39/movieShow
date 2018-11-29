//
//  SQliteManager.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/21.
//  Copyright © 2018 heyijia All rights reserved.
//

import Foundation
import SQLite

struct SQLiteManager {
    //数据库连接
    var database: Connection!
    init() {
        do {
            let path = NSHomeDirectory() + "/Documents/ios_movie.sqlite3"
            database = try Connection(path)
            print(path)
            print("与数据库建立连接！")
        } catch  { print(error) }
    }

    
    ///用户 表
    private let movies_user = Table("movies_user")
    
    ///收藏的电影 表
    private let movies_like = Table("movies_like")
    
    let id = Expression<Int64>("id")
    let username = Expression<String>("username")
    let password = Expression<String>("password")
    //表字段
    let movieid = Expression<String>("movieid")
    let title = Expression<String>("title")
    let average = Expression<String>("average")
    let imgmedium = Expression<String>("imgmedium")
    let year = Expression<String>("year")
    ///创建表
    func tableLampCreate() -> Void {
            try! database.run(movies_user.create(ifNotExists: true, block: { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(username)
                t.column(password)
            }))
    }
    ///插入一组数据
    func insert(_ titles: [MovieUser]) { _ = titles.map { insert($0) }}
    /// 插入一条数据
    func insert(_ title : MovieUser) {
        // 如果数据库中该条数据不存在， 插入
        if !exist(title) {
            let insert = movies_user.insert(username <- title.username, password <- title.password)
            //插入数据
            try! database.run(insert)
            print("插入数据！")
        }
        
    }
    /// 判断数据库中某一条数据是否存在
    func exist(_ title: MovieUser) -> Bool {
        // 取出该的数据
        let title = movies_user.filter(username == title.username)
        // 判断该条数据是否存在，没有直接的方法
        // 可以根据 count 是否是 0 来判断是否存在这条数据，0 表示没有该条数据，1 表示存在该条数据
        let count = try! database.scalar(title.count)
        
        return count != 0
    }
    
    /// 判断数据库中用户名和密码
    func islogin(_ title: MovieUser) -> Bool {
        // 取出该的数据
        let title = movies_user.filter(username == title.username && password == title.password)
        // 判断该条数据是否存在，没有直接的方法
        // 可以根据 count 是否是 0 来判断是否存在这条数据，0 表示没有该条数据，1 表示存在该条数据
        let count = try! database.scalar(title.count)
        
        return count != 0
    }
    
    
    /// 查询所有

    
    /// 更新
    func update( _ newsTitle : MovieUser ) {
        // 取出数据库中数据
        let title = movies_user.filter(username == newsTitle.username)
    }
    
    
    ///创建电影收藏表
    func tablemovlike() -> Void {
        try! database.run(movies_like.create(ifNotExists: true, block: { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(username)
            t.column(movieid)
            t.column(title)
            t.column(average)
            t.column(imgmedium)
            t.column(year)
        }))
    }
    func insertmov(_ mov : MovieLike) {
        // 如果数据库中该条数据不存在， 插入
        if !existmov(mov) {
            let insert = movies_user.insert(username <- mov.username, movieid <- mov.movieid, title <- mov.title, average <- mov.average, imgmedium <- mov.imgmedium, year <- mov.year)
            //插入数据
            try! database.run(insert)
            print("插入数据！")
        }
        
    }
    
    /// 判断数据库中某一条电影喜欢数据是否存在
    func existmov(_ movie: MovieLike) -> Bool {
        // 取出该的数据
        let title = movies_like.filter(username == movie.username && movieid == movie.movieid)
        // 判断该条数据是否存在，没有直接的方法
        // 可以根据 count 是否是 0 来判断是否存在这条数据，0 表示没有该条数据，1 表示存在该条数据
        let count = try! database.scalar(title.count)
        
        return count != 0
    }
    
}
