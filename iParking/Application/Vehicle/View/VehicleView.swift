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
    
    var vehicleTypeEnum: VehicleTypeEnum = .Official
    
    var viewModel: VehicleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        licensePlateTextField.becomeFirstResponder()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        licensePlateTextField.delegate = self
        
        viewModel = VehicleViewModel(view: self, vehicleTypeEnum: vehicleTypeEnum)
        
        
        switch vehicleTypeEnum {
        case .Official:
            title = "REGISTRAR VEHICULO OFICIAL"
            break
        case .Resident:
            title = "REGISTRAR VEHICULO RESIDENTE"
            break
        default:
            break
        }
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
        viewModel?.onAddNewVehicle(licensePlate: textFieldText, vehicleTypeEnum: vehicleTypeEnum)
    }
    
}

extension VehicleView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberVehicles = viewModel?.vehicles.count else { return 0 }
        
        return numberVehicles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vehicleViewModel = viewModel else { return UITableViewCell() }
        let vehicle = vehicleViewModel.vehicles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Nro. de Placa: \(vehicle.licensePlate), Tipo: \(String(describing: vehicle.type!.descrip))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension VehicleView: VehicleViewModelDelegate{
    func reloadItems() {
        mainTableView.reloadData()
    }
}


extension VehicleView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 7
   }
}
