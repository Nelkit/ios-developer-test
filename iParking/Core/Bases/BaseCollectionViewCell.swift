//
//  BaseCollectionViewCell.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell{
    
    //MARK: - Variables
    
    let displayedOnCompactDevice = UIDevice.current.userInterfaceIdiom == .phone
    weak var indexPath: NSIndexPath?
    
    convenience init(){
        self.init(frame: CGRect.zero)
        onInit()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        onInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        onInit()
    }
    
    //MARK: - Private Functions
    
    private func onInit(){
        isOpaque=true
        backgroundColor=UIColor.white
        layer.shouldRasterize=true
        layer.rasterizationScale=UIScreen.main.scale
        for view in [self,contentView]{
            view.translatesAutoresizingMaskIntoConstraints=false
        }
        layer.cornerRadius=2
        setup()
    }
    
    //MARK: - Public Functions
    
    public func setup(){ }
    
    public func removeAutoConstraintsFromView(vs: Array<UIView>){
        for v in vs{v.translatesAutoresizingMaskIntoConstraints=false}
    }
}


