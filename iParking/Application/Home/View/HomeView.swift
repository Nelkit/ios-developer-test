//
//  HomeView.swift
//  iParking
//
//  Created by Nelkit Chavez on 21/10/20.
//

import UIKit

class HomeView: BaseController {
    @IBOutlet weak var menuCollectionView: UICollectionView!
    var viewModel: HomeViewModel?
    @IBOutlet weak var startMonthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        menuCollectionView.backgroundColor = Colors.background()
        menuCollectionView.contentMode = .scaleAspectFill
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        menuCollectionView.collectionViewLayout = layout
        
        viewModel = HomeViewModel()

    }
    
    
}


extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numbersOptions = viewModel?.options.count else { return 0 }
        return numbersOptions
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let optionViewModel = viewModel?.options[indexPath.row] else { return UICollectionViewCell() }
        
        let cell: MenuCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.reuseIdentifier, for: indexPath) as! MenuCell
        cell.config(withViewModel: optionViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let optionViewModel = viewModel?.options[indexPath.row] else { return }
        
        switch optionViewModel.id {
        case 1:
            let vc = self.storyboard(by:"Main").instantiateViewController(withIdentifier:  ViewNames.logView) as! LogView
            vc.actionLog = .Entry
            
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
            break
        case 2:
            let vc = self.storyboard(by:"Main").instantiateViewController(withIdentifier:  ViewNames.logView) as! LogView
            vc.actionLog = .Exit
            
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
            break
        case 3:
            let vc = self.storyboard(by:"Main").instantiateViewController(withIdentifier:  ViewNames.vehicleView) as! VehicleView
            vc.vehicleTypeEnum = .Official
            
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
            break
        case 4:
            let vc = self.storyboard(by:"Main").instantiateViewController(withIdentifier:  ViewNames.vehicleView) as! VehicleView
            vc.vehicleTypeEnum = .Resident
            
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
            break
        case 5:
            viewModel?.resetMonth()
            
            startMonthLabel.isHidden = false
            startMonthLabel.layer.masksToBounds = true
            startMonthLabel.layer.cornerRadius = 20
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [self] in
                startMonthLabel.isHidden = true
            })
            break
        case 6:
            let vc = self.storyboard(by:"Main").instantiateViewController(withIdentifier:  ViewNames.paymentView) as! PaymentView
            
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
}




