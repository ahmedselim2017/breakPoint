//
//  GrupFeedVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 18.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class GrupFeedVC: UIViewController {

    @IBOutlet weak var tabloGoruntuleyici: UITableView!
    @IBOutlet weak var lblKullanicilar: UILabel!
    @IBOutlet weak var txtMesaj: UITextField!
    @IBOutlet weak var vwGonder: UIView!
    @IBOutlet weak var lblGrupBaslik: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vwGonder.klavyeyeBaglan();
    }
    
    @IBAction func btnGeriBasildi(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func btnGonderBasildi(_ sender: Any) {
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
