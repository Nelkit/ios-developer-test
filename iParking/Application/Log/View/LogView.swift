//
//  LogView.swift
//  iParking
//
//  Created by Nelkit Chavez on 23/10/20.
//

import UIKit

protocol LogViewModelDelegate {
    func logEntrySuccess(vehicle: Vehicle)
    func logEntryFail(msg: String)
    
    func logExitSuccess(log: ParkingLog)
    func logExitFail(msg: String)
    
    func showTotalAmountToPay(amount: String)
}

class LogView: BaseController {
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logButton: UIButton!
    
    @IBOutlet weak var messageActionLabel: UILabel!
    @IBOutlet weak var amountPaymentLbl: UILabel!
    
    var viewModel: LogViewModel?
    var actionLog: VehicleParkingActionEnum = .Entry
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        licensePlateTextField.becomeFirstResponder()
        licensePlateTextField.delegate = self
        
        switch actionLog {
        case .Entry:
            title = "REGISTRAR ENTRADA"
            titleLabel.text = "REGISTRAR ENTRADA"
            logButton.setTitle("Registrar Entrada", for: .normal)
            break
        case .Exit:
            title = "REGISTRAR SALIDA"
            titleLabel.text = "REGISTRAR SALIDA"
            logButton.setTitle("Registrar Salida", for: .normal)
            break
        }
        
        viewModel = LogViewModel(view: self)
    }
    
    override func keyboardDidDisappear() {
        viewBottomConstraint.constant = 100
    }
    
    override func keyboardDidAppear(_ keyboardHeight: CGFloat) {
        viewBottomConstraint.constant = keyboardHeight
    }

    @IBAction func logVehicleParking(_ sender: Any) {
        guard let textFieldText = licensePlateTextField.text else {
            return
        }
        
        switch actionLog {
        case .Entry:
            viewModel?.onLogEntryVehicle(licensePlate: textFieldText)
            break
        case .Exit:
            viewModel?.onLogExitVehicle(licensePlate: textFieldText)
            break
        }
        
    }
}

extension LogView: LogViewModelDelegate{
    func showTotalAmountToPay(amount: String) {
        titleLabel.text = "El importe a cobrar a este vehiculo sera de: "
        amountPaymentLbl.isHidden = false
        amountPaymentLbl.text = "$\(amount)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: { [self] in
            titleLabel.text = "REGISTRAR ENTRADA"
            amountPaymentLbl.isHidden = true
        })
        
    }
    
    func logExitSuccess(log: ParkingLog) {
        messageActionLabel.isHidden = false
        messageActionLabel.text = "Se registro correctamente la salida del vehiculo con placa: \(log.vehicle!.licensePlate)"
        messageActionLabel.textColor = .green
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: { [self] in
            messageActionLabel.isHidden = true
        })
    }
    
    func logExitFail(msg: String) {
        messageActionLabel.isHidden = false
        messageActionLabel.text = msg
        messageActionLabel.textColor = .green
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: { [self] in
            messageActionLabel.isHidden = true
        })
    }
    
    func logEntrySuccess(vehicle: Vehicle) {
        messageActionLabel.isHidden = false
        messageActionLabel.text = "Se registro correctamente la entrada del vehiculo con placa: \(vehicle.licensePlate)"
        messageActionLabel.textColor = .green
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: { [self] in
            messageActionLabel.isHidden = true
        })
    }
    
    func logEntryFail(msg: String) {
        messageActionLabel.isHidden = false
        messageActionLabel.text = msg
        messageActionLabel.textColor = .red
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: { [self] in
            messageActionLabel.isHidden = true
        })
    }
    

}

extension LogView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 7
   }
}
