//
//  GrupOlusturVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 17.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class GrupOlusturVC: UIViewController {

    @IBOutlet weak var txtBaslik: TxtGiris!
    @IBOutlet weak var txtAciklama: TxtGiris!
    @IBOutlet weak var txtKatilimcilar: TxtGiris!
    
    @IBOutlet weak var lblKatilimcilar: UILabel!
    
    @IBOutlet weak var tabloGoruntuleyici: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabloGoruntuleyici.delegate=self;
        tabloGoruntuleyici.dataSource=self;
    }
    
    @IBAction func btnGrupOlusturBasildi(_ sender: Any) {
    }
    
    @IBAction func btnGeriBasildi(_ sender: Any) {
        dismiss(animated: true, completion: nil);
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

extension GrupOlusturVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hucre=tableView.dequeueReusableCell(withIdentifier: TB_ID_KULLANICI_HUCRESI) as? KullaniciHucresi else {return UITableViewCell();}
        let rsmProfil=UIImage(named:"defaultProfileImage");
        hucre.hucreleriAyarla(rsmProfil: rsmProfil!, eposta: "sanane123@123", secilmisMi: true);
        return hucre;
    }
}
