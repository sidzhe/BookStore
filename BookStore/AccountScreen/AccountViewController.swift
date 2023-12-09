// UIImagePicker
// Symbols Sf

import UIKit
import SnapKit

class AccountViewController: UIViewController, UINavigationControllerDelegate {
    
    let nameTextField = UITextField()
    let pushSelectImageAction = UIButton(type: .custom)
    let avatar = UIImageView()
    let myListsTextField = UIButton()
    let arrowButton = UIButton()
    
    

    //MARK: - Presenter
    var presenter: AccountPresenterProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initialize()
        loadUserDefaults()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        safeUserDefaults()
        
    }
    
     func initialize(){
         
        
        
        let label = UILabel()
        label.text = "Acount"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
        
//        let avatar = UIImageView()
        avatar.image = UIImage(systemName: "person")
        avatar.tintColor = .black
         avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 50
        view.addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(75)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        view.addSubview(pushSelectImageAction)
         pushSelectImageAction.backgroundColor = .clear
         pushSelectImageAction.layer.borderWidth = 0
         pushSelectImageAction.snp.makeConstraints { make in
             make.center.equalTo(avatar)
             make.width.equalTo(avatar)
             make.height.equalTo(avatar)
         }
         
         pushSelectImageAction.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
        
            
        nameTextField.backgroundColor = .lightGray
        nameTextField.borderStyle = .roundedRect
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            nameTextField.placeholder = "Your name"
        }
         
         
         arrowButton.setTitle("arrowshape.right.cirkle", for: .normal)
         view.addSubview(arrowButton)
         arrowButton.snp.makeConstraints { make in
             
         }
         
         
         
    }
    

    
    @objc func pushButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
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
    
//    func listsTextFieldShouldReturn(_ textField: UITextField) -> Bool {
//        myListsTextField.endEditing(true)
//        return true
//    }
    
}

//MARK: - UIImagePickerControllerDelegate //Расширение для сохранения картинки в UIImageView

extension AccountViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatar.image = selectedImage
        } else if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatar.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func safeUserDefaults() {
        print("cxx")
        guard let image = avatar.image else { return }
        let imageData = image.pngData()
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        
        // добавить сохранение имени текстФилда
    }

    func loadUserDefaults() {
        if let imageData = UserDefaults.standard.data(forKey: "savedImage") {
            let image = UIImage(data: imageData)
            avatar.image = image
        }
    }

    
}


