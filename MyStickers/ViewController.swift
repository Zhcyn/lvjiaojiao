//
//  ViewController.swift
//  MyStickers
//
//  Created by 禚恒 on 2020/6/29.
//  Copyright © 2020 Summer. All rights reserved.
//

import UIKit
let titleBarHeight: CGFloat = 40.0
let tabViewHeight: CGFloat = 40.0

let kUIScreenW = UIScreen.main.bounds.size.width
let kUIScreenH = UIScreen.main.bounds.size.height
class ViewController: UIViewController {
    
    
    var stickers = NSArray()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        let viewHeight: CGFloat = UIScreen.main.bounds.size.height
        let frame = CGRect.init(x: 0, y: 200+titleBarHeight, width: kUIScreenW, height: kUIScreenH-200-titleBarHeight)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        return collectionView
    }()

    //MARK: - Private Property
    private var toIndex: Int = 0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        loadData()
        configSubviews()
    }
    
    
    //MARK: - Public Mehtod
    //MARK: - Data
    public func loadData() {
        stickers = ["Sticker 1","Sticker 2","Sticker 3","Sticker 4","Sticker 5","Sticker 6","Sticker 7","Sticker 8","Sticker 9","Sticker 10","Sticker 11"]
    }

    //MARK: - Private Mehtods
    private func configSubviews() {
        self.view.backgroundColor = .white
        
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        headerView.frame = CGRect(x: 15, y: titleBarHeight, width: kUIScreenW-30, height: 200)
        self.view.addSubview(headerView)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KImage")
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        headerView.addSubview(imageView)
        
        let nameLabel = UILabel()
        nameLabel.text = "绿角角\n最棒啦！！"
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.black
        nameLabel.frame = CGRect(x: 210, y: 50, width: kUIScreenW-200-20-30, height: 100)
        nameLabel.numberOfLines = 2
        headerView.addSubview(nameLabel)
        
        
        
        collectionView.backgroundColor = #colorLiteral(red: 0.6476759315, green: 0.7409530282, blue: 0.8014042377, alpha: 1)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ItemsCell.self, forCellWithReuseIdentifier: NSStringFromClass(ItemsCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ItemsCell.self), for: indexPath) as? ItemsCell {
            cell.configView(titleString: (stickers[indexPath.row] as! NSString))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
        
        
//        let text = "绿角角贴纸最棒啦！！！"
        let image = UIImage(named: stickers[indexPath.row] as! String)
        let activityVC = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        // 如果是ipad, 那么需要使用pop的方式显示方向界面
        present(activityVC, animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (UIScreen.main.bounds.size.width - 40) / 2, height: (UIScreen.main.bounds.size.width - 40) / 2)
        return size
    }
    
    
    
    
}


extension UIColor {
    //返回随机颜色
    class var randomColor: UIColor {
        get
        {
            let red = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
