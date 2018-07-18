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
    @IBOutlet weak var btnGonder: UIButton!
    @IBOutlet weak var bosluk: NSLayoutConstraint!
    @IBOutlet weak var altbosluk: NSLayoutConstraint!
    
    var grup:Grup?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnGonder.klavyeyeBaglan();
        txtMesaj.klavyeyeBaglan();
        
    }
    
    
    
    func initVeri(grup:Grup){
        self.grup=grup;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        lblGrupBaslik.text=grup?.grupBaslik;
        lblKullanicilar.text=grup?.katilimcilar.joined(separator: ",");
        
        
    }
    
    @objc func txtDegisti(_ txt:UITextField){

        vwGonder.isHidden=false;
        
     

        
        loadViewIfNeeded();
        
        
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

