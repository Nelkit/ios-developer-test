//
//  VehicleView.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import UIKit

protocol VehicleViewModelDelegate {
    func reloadItems()
}

class VehicleView: BaseController {
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel: VehicleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        licensePlateTextField.becomeFirstResponder()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        viewModel = VehicleViewModel(view: self)
    }

    override func keyboardDidDisappear() {
        viewBottomConstraint.constant = 0
    }
    
    override func keyboardDidAppear(_ keyboardHeight: CGFloat) {
        viewBottomConstraint.constant = keyboardHeight
    }
    
    @IBAction func saveNewVehicle(_ sender: Any) {
        guard let textFieldText = licensePlateTextField.text else {
            return
        }
        viewModel?.onAddNewVehicle(licensePlate: textFieldText)
    }
    
}

extension VehicleView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberVehicles = viewModel?.vehicles.count else { return 0 }
        
        return numberVehicles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vehicleViewModel = viewModel?.vehicles[indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "Nro. de Placa: \(vehicleViewModel.licensePlate)"
        return cell
    }
}

extension VehicleView: VehicleViewModelDelegate{
    func reloadItems() {
        mainTableView.reloadData()
    }
}
