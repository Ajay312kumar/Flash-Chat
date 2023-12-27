

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                    let errorMessage = self?.getErrorMessage(for: e)
                    self?.showAlert(message: errorMessage)
                } else {
                    self?.performSegue(withIdentifier: k.LoginToChat, sender: self)
                }
            }
        }
    }
    
    func getErrorMessage(for error: Error) -> String {
            let errorCode = (error as NSError).code
            var errorMessage = "Login failed. Please try again."

            switch errorCode {
            case AuthErrorCode.invalidEmail.rawValue:
                errorMessage = "Invalid email. Please enter a valid email."
            case AuthErrorCode.wrongPassword.rawValue:
                errorMessage = "Invalid password. Please enter a valid password."
            default:
                break
            }

            return errorMessage
        }

        func showAlert(message: String?) {
            let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    
}
