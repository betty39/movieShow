//
//  MovieLIstViewCell.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/29.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class MovieLIstViewCell: UITableViewCell, RegisterCellFromNib {

    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var imageVIEW: UIImageView!
    @IBOutlet weak var yearText: UILabel!
    @IBOutlet weak var rateText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
