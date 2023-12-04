

import UIKit
import SnapKit

class AccountViewController: UIViewController {
    
    let nameTextField = UITextField()
    
    //MARK: - Presenter
    var presenter: AccountPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initialize()
    }
    
    private func initialize(){
        
        let label = UILabel()
        label.text = "Acount"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
        
        let avatar = UIView()
        avatar.backgroundColor = .black
        avatar.layer.cornerRadius = 50
        view.addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(75)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        //let nameTextField = UITextField()
        nameTextField.backgroundColor = .purple
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(20)
        }
        
        
        
        
    }
}
    //MARK: - AccountViewProtocol
    extension AccountViewController: AccountViewProtocol {
       
    }


//MARK: - UITextFieldDelegate

extension AccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if nameTextField.text != ""{
            return true
        } else {
            textField.placeholder = "Your name"
            return false
        }
    }
}
