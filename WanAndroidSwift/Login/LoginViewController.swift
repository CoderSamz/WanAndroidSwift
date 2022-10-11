//
//  LoginViewController.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTF(with: mailTF, imageNamed: "email")
        setupTF(with: passwordTF, imageNamed: "password")
    }
    
    func setupTF(with textField: UITextField, imageNamed: String) {
        textField.leftViewMode = .always
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
        let imageView = UIImageView(image: UIImage(named: imageNamed))
        imageView.center = view.center
        view.addSubview(imageView)
        textField.leftView = view
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://www.wanandroid.com/login")!, options: [:], completionHandler: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
