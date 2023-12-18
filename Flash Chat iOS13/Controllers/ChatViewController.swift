

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    let message: [Messages] = [Messages(sender: "1@2.com", body: "Hey!"),
                               Messages(sender: "a@b.com", body: "Hello!"),
                               Messages(sender: "1@2.com", body: "Bye!")
                             ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: k.cellNibName, bundle: nil), forCellReuseIdentifier: k.cellIdentifier)

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
    

}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: k.cellIdentifier, for: indexPath) as! MessageCellTableViewCell
        
        cell.label.text = message[indexPath.row].sender
        return cell
        
        
    }
    
    
    
    
}
