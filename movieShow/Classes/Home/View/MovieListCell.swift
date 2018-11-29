//
//  MovieListCell.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/28.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell, RegisterCellFromNib{
    @IBOutlet var movieCellView: UITableViewCell!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var yearText: UILabel!
    @IBOutlet weak var descText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        theme_backgroundColor = "colors.cellBackgroundColor"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
