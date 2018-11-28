//
//  ZLAttentCell.swift
//  movieShow
//
//  Created by 张彦林 on 2018/11/14.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit

class ZLAttentCell: UITableViewCell, RegisterCellFromNib {

    /// 点击了第几个 cell
    var myConcernSelected: ((_ myAttent: ZLMyAttent)->())?
    ///标题
    @IBOutlet weak var leftLabel: UILabel!
    ///副标题
    @IBOutlet weak var rightLabel: UILabel!
    ///箭头
    @IBOutlet weak var rigjtImageView: UIImageView!
    
    @IBOutlet weak var topView: UIView!
    
    ///关注头像
    @IBOutlet weak var attentImageView: UIImageView!
    ///关注CollectionView
    @IBOutlet weak var attentCollectionView: UICollectionView!
    ///分割线
    @IBOutlet weak var separatorView: UIView!
    var attents = [ZLMyAttent](){
        didSet {
            attentCollectionView.reloadData()
        }
    }
    
    
    var zlMyCellModel : ZLMyCellModel? {
        didSet{
            leftLabel.text = zlMyCellModel?.text
            rightLabel.text = zlMyCellModel?.grey_text
        }
    }
    
    var zlMyAtten : ZLMyAttent? {
        didSet {
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        attentCollectionView.collectionViewLayout = MyAttentFlowLayout()
        attentCollectionView.delegate = self
        attentCollectionView.dataSource = self
        attentCollectionView.zl_registerCell(cell: ZLConcernCell.self)
        
        leftLabel.theme_textColor = "colors.black";
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rigjtImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        topView.theme_backgroundColor = "colors.cellBackgroundColor"
        attentCollectionView.theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension ZLAttentCell: UICollectionViewDelegate, UICollectionViewDataSource {
   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.zl_dequeueReusableCell(indexPath: indexPath) as ZLConcernCell
        cell.zlMyConcern = attents[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myConcernSelected!(attents[indexPath.item])
        
    }
}

class MyAttentFlowLayout : UICollectionViewFlowLayout {
    override func prepare() {
        //item大小
        itemSize = CGSize(width: 58, height: 73)
        //横向间距
        minimumLineSpacing = 0
        //纵向间距
        minimumInteritemSpacing = 0
        //每个item的上下左右边距
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //设置水平滚动
        scrollDirection = .horizontal
    }
}
