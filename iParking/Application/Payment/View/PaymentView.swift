//
//  PaymentView.swift
//  iParking
//
//  Created by Nelkit Chavez on 23/10/20.
//

import UIKit

class PaymentView: BaseController {
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel: PaymentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        title = "INFORME DE PAGOS RESIDENTES"
        
        viewModel = PaymentViewModel(view: self)
    }
}

extension PaymentView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberLogs = viewModel?.logList.count else { return 0 }
        
        return numberLogs
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let logViewModel = viewModel else { return UITableViewCell() }
        let log = logViewModel.logList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.numberOfLines = 0
        let database = DatabaseManager()
        if let vehicleType = database.read(VehicleType.self).filter("code='\(VehicleTypeEnum.Resident.rawValue)'").first{
            let totalFare = log.totalTime * vehicleType.timefare
            cell.textLabel?.text = "Nro. de Placa: \(log.licensePlate) | Tiempo \(log.totalTime.format(toPlaces: 2))min | Total a Pagar: $\(totalFare.format(toPlaces: 2))"
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
