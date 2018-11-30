//
//  ZLMineViewController.swift
//  movieShow
//
//  Created by 何怡家 on 2018/11/9.
//  Copyright © 2018 heyijia All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift



let zlMyOtherCell: String = "zlMyOtherCell"

class ZLMineViewController: UITableViewController {

    private let disposeBag = DisposeBag()
    
    var sections = [[ZLMyCellModel]]()
    fileprivate lazy var headerView: ZLNoLoginHeaderView = {
        let headerView = ZLNoLoginHeaderView.loadViewFromNib()
        return headerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = UIColor.globalBackgroundColor()
        tableView.separatorStyle = .none
        
        tableView.zl_registerCell(cell: ZLMyOtherCell.self)
        loadData()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        let userDefault = UserDefaults.standard
        let username:String = userDefault.string(forKey: "username")!
        headerView.moreButton.setTitle(username, for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    
}

extension ZLMineViewController {
    ///加载数据
    func loadData() {
        let string = "{\"text\": \"我的收藏\", \"grey_text\": \"\", \"key\": \"star\"}"
        let myAttent = ZLMyCellModel.deserialize(from: string)
        var myAttents = [ZLMyCellModel]()
        myAttents.append(myAttent!)
        self.sections.append(myAttents)
        self.tableView.reloadData()
        let userDefault = UserDefaults.standard
        var username:String = userDefault.string(forKey: "username")!
        headerView.moreButton.setTitle(username, for: .normal)
        //if (username.characters.count <= 0) {
        headerView.moreButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                let stodryboard = UIStoryboard(name: "ZLMoreLoginViewController", bundle: nil)
                let moreLogin = stodryboard.instantiateViewController(withIdentifier: "ZLMoreLoginViewController") as! ZLMoreLoginViewController
                moreLogin.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIPhoneX ? 44 : 20))))
                
                self!.present(moreLogin, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        //}
    }
        
}


extension ZLMineViewController {
    // 每组头部的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.zl_dequeueReusableCell(indexPath: indexPath) as ZLMyOtherCell
        let section = sections[indexPath.section]
        let myCellModel = section[indexPath.row]
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        
        return cell
        
    }
    // 行高
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let systemSVC = MyCollectionViewController()
        self.navigationController?.pushViewController(systemSVC, animated: true)
        
    }
    
    //这只吸顶效果
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = zlMyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / zlMyHeaderViewHeight
            headerView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) * 0.5, y: offsetY, width: screenWidth * f, height: totalOffset)
        }
        
    }

}
