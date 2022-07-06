//
//  ProfileInputView.swift
//  EatGreat
//
//  Created by Book on 2022/7/4.
//

import UIKit

protocol ProfileInputViewDelegate:AnyObject {
    func textFieldUpdate(_ view:ProfileInputView)
}

class ProfileInputView: UIView {
    
    weak var delegate:ProfileInputViewDelegate?
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.textColor = .grey3
        return label
    }()
    
    private lazy var pickerView:UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var textField:UITextField = {
        let textField = UITextField()
        textField.leftView = .init(frame: CGRect.init(x: 0, y: 0, width: 16, height: 1))
        textField.leftViewMode = .always
        textField.textColor = .grey5
        textField.font = .body
        textField.layer.borderColor = UIColor.grey2.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.delegate = self
        return textField
    }()
    
    var pickerDataSource:[String] = []
    
    var isDropDownStyle:Bool = false {
        didSet {
            updateFrame()
            updateTextFieldInputView()
        }
    }
    
    let errorLabel:UILabel = {
        let label = UILabel()
        label.textColor = .error
        label.font = .footnote
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(errorLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.height.equalTo(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
    }
    
    private func updateFrame() {
        if isDropDownStyle {
            let rightView = UIView()
            
            let imageView = UIImageView()
            imageView.image = .init(named: "KeyboardArrowDown")
            rightView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(16)
            }
            
            textField.rightView = rightView
            textField.rightViewMode = .always
        } else {
            textField.rightView = nil
            textField.rightViewMode = .never
        }
    }
    
    private func updateTextFieldInputView() {
        if isDropDownStyle {
            textField.inputView = pickerView
        } else {
            textField.inputView = nil
        }
    }
}

// MARK: - UITextFieldDelegate
extension ProfileInputView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.themePrimary.cgColor
        titleLabel.textColor = UIColor.themePrimary
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.grey2.cgColor
        titleLabel.textColor = UIColor.grey2
        delegate?.textFieldUpdate(self)
    }
}

// MARK: - UIPickerViewDelegate
extension ProfileInputView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        pickerDataSource.isEmpty ? 0 : 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerDataSource[row]
    }
}
