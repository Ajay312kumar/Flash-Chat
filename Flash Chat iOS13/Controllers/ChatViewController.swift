

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal
import Network

class ChatViewController: UIViewController {

    //MARK: -IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    //MARK: -variables
    var message: [Messages] = []
    let db = Firestore.firestore()
    
    //MARK: -Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        tableView.delegate = self
        tableView.dataSource = self
        loadMessage()
        
        tableView.register(UINib(nibName: k.cellNibName, bundle: nil), forCellReuseIdentifier: k.cellIdentifier)

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(k.FStore.collectionName).addDocument(data: [k.FStore.senderField: messageSender,
                 k.FStore.bodyField: messageBody]){
                (error) in
                if let e = error {
                    print("there was an issue saving data to firestore, \(e)")
                }else{
                    print("Successfully saved data.")
                }
            }
        }
    }
    
    
    func loadMessage() {
        
        message = []
        
        db.collection(k.FStore.collectionName).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("there was an issue retrieving data from FireStrore. \(e)")
            }else {
                
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[k.FStore.senderField] as? String, let messageBody = data[k.FStore.bodyField] as? String {
                            let newMessage = Messages(sender: messageSender, body: messageBody)
                            self.message.append(newMessage)
                        }
                    }
                }
            }
            
        }
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

//MARK: -extension
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
