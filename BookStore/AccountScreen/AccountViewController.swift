// UIImagePicker
// Symbols Sf

import UIKit
import SnapKit

final class AccountViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Presenter
    var presenter: AccountPresenterProtocol!
    
    //MARK: - UI Elements
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name:"
        textField.delegate = self
        return textField
    }()
    
    private lazy var pushSelectImageAction: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(pushToViewContr), for: .touchUpInside)
        return button
    }()
    
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(systemName: "person.circle.fill")
        avatar.tintColor = .black
        return avatar
    }()
    
    private lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right")
        arrow.tintColor = .black
        return arrow
    }()
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var labelButton: UILabel = {
        let label = UILabel()
        label.text = "My lists"
        label.textColor = .systemGray
        return label
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        loadUserDefaults()
        
    }
    
    //MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        safeUserDefaults()
        
    }
    
    private func initialize(){
        title = "Account"
        view.backgroundColor = .white
        view.addSubview(avatar)
        view.addSubview(pushSelectImageAction)
        view.addSubview(nameTextField)
        view.addSubview(customView)
        view.addSubview(nextButton)
        
        customView.addSubview(labelButton)
        customView.addSubview(arrow)
        
        avatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(30)
            make.size.equalTo(100)
        }
        
        pushSelectImageAction.snp.makeConstraints { make in
            make.center.equalTo(avatar)
            make.size.equalTo(150)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(avatar.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        customView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).inset(-25)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        labelButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
        
        arrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(customView.snp.height)
            make.width.equalTo(customView.snp.width)
            make.center.equalTo(customView.snp.center)
        }
    }
    
    //MARK: - Targets
    @objc private func pushButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @objc private func pushToViewContr() {
        let listViewController = ListViewController()
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    //MARK: - UserDefaults
    private func safeUserDefaults() {
        guard let image = avatar.image else { return }
        let imageData = image.pngData()
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        UserDefaults.standard.set(nameTextField.text, forKey: "savedText")
    }
    
    private func loadUserDefaults() {
        if let imageData = UserDefaults.standard.data(forKey: "savedImage") {
            let image = UIImage(data: imageData)
            avatar.image = image
            avatar.clipsToBounds = true
            avatar.layer.cornerRadius = 50
        }
        
        if let saveText = UserDefaults.standard.string(forKey: "savedText") {
            nameTextField.text = saveText
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
}
