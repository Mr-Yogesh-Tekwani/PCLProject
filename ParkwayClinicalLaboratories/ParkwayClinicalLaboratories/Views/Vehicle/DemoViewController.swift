//
//  DemoViewController.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/19/23.
//
import UIKit

class DemoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dataForDropdown = ["Option 1", "Option 2", "Option 3", "Option 4"] // Replace this with your data for the dropdown
    
    var selectedOption: String?
    
    lazy var dropdownTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select an option"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = pickerView
        textField.inputAccessoryView = createToolbar() // Add the toolbar as the input accessory view
        return textField
    }()

    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(dropdownTextField)

        NSLayoutConstraint.activate([
            dropdownTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dropdownTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            dropdownTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - UIPickerViewDataSource and UIPickerViewDelegate methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataForDropdown.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataForDropdown[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = dataForDropdown[row]
        dropdownTextField.text = dataForDropdown[row]
    }

    // Create a toolbar with "Done" and "Cancel" buttons
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)

        return toolbar
    }

    @objc private func doneButtonTapped() {
        print("Selected Option = ",selectedOption)
        dropdownTextField.resignFirstResponder()
    }

    @objc private func cancelButtonTapped() {
        dropdownTextField.text = nil
        dropdownTextField.resignFirstResponder()
    }
}
