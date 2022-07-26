//
//  CountViewController.swift
//  squidCount
//
//  Created by user on 27.07.2022.
//

import UIKit

class CountViewController: UIViewController {
    @IBOutlet var figureImageView: UIImageView!
    
    @IBOutlet var perimeterLabel: UILabel!
    @IBOutlet var squareLabel: UILabel!
    
    @IBOutlet var radiusTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var widthTextField: UITextField!
    @IBOutlet var sideOneTextField: UITextField!
    @IBOutlet var sideTwoTextField: UITextField!
    @IBOutlet var sideThreeTextField: UITextField!
    
    
    @IBOutlet var triangleParameters: UIStackView!
    @IBOutlet var circleParameters: UIStackView!
    @IBOutlet var rectangleParameters: UIStackView!
    
    @IBOutlet var results: UIStackView!
    
    var shape: Shape!
    
    private var textFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        textFields = [radiusTextField, widthTextField, heightTextField, sideOneTextField, sideTwoTextField, sideThreeTextField]
        for textField in textFields {
            textField.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func countButtonTapped() {
        switch shape {
        case .circle:
            var figure = Circle.getCircle()
            if !(checkTextFields(radiusTextField)) {
                guard let radiusTextField = radiusTextField.text else { return }
                figure.radius = Double(radiusTextField) ?? 0
                perimeterLabel.text = String(format: "%.2f", figure.perimeter)
                squareLabel.text = String(format: "%.2f", figure.square)
                results.isHidden = false
            }
        case .rectangle:
            var figure = Rectangle.getRectangle()
            if !(checkTextFields(heightTextField, widthTextField)) {
                guard let heightTextField = heightTextField.text,
                      let widthTextField = widthTextField.text
                else { return }
                figure.height = Double(heightTextField) ?? 0
                figure.width = Double(widthTextField) ?? 0
                perimeterLabel.text = String(format: "%.2f", figure.perimeter)
                squareLabel.text = String(format: "%.2f", figure.square)
                results.isHidden = false
            }
        default:
            var figure = Triangle.getTriangle()
            if !(checkTextFields(sideOneTextField, sideTwoTextField, sideThreeTextField)) {
                guard let sideOneTextField = sideOneTextField.text,
                      let sideTwoTextField = sideTwoTextField.text,
                      let sideThreeTextField = sideThreeTextField.text
                else { return }
                figure.sideOne = Double(sideOneTextField) ?? 0
                figure.sideTwo = Double(sideTwoTextField) ?? 0
                figure.sideThree = Double(sideThreeTextField) ?? 0
                perimeterLabel.text = String(format: "%.2f", figure.perimeter)
                squareLabel.text = String(format: "%.2f", figure.square)
                results.isHidden = false
            }
        }
    }
    
    private func setupUI() {
        switch shape {
        case .circle:
            let figure = Circle.getCircle()
            title = figure.name
            figureImageView.image = UIImage(named: figure.imageName)
            circleParameters.isHidden.toggle()
        case .rectangle:
            let figure = Rectangle.getRectangle()
            title = figure.name
            figureImageView.image = UIImage(named: figure.imageName)
            rectangleParameters.isHidden.toggle()
        default:
            let figure = Triangle.getTriangle()
            title = figure.name
            figureImageView.image = UIImage(named: figure.imageName)
            triangleParameters.isHidden.toggle()
        }
    }
    
    private func checkTextFields(_ textFields: UITextField...) -> Bool {
        for textField in textFields {
            if textField.text!.isEmpty {
                showAlert(with: "Wrong value", and: "Enter the correct value")
                return true
            }
        }
        
        return false
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

//MARK: UITextField Delegate
extension CountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text != "" || string != "" {
            let value = (textField.text ?? "") + string
            return Double(value) != nil
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        
        let flexSpacingItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                              target: nil,
                                              action: nil)
        
        keyboardToolBar.items = [flexSpacingItem, doneButton]
    }
}


