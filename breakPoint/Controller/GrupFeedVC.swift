//
//  GrupFeedVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 18.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit;
import Firebase;

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
    var mesajDizi=[Mesaj]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        btnGonder.klavyeyeBaglan();
//        txtMesaj.klavyeyeBaglan();
        klavyeyeBaglan();
        tabloGoruntuleyici.delegate=self;
        tabloGoruntuleyici.dataSource=self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        lblGrupBaslik.text=grup?.grupBaslik;
        lblKullanicilar.text=grup?.katilimcilar.joined(separator: ",");
        
        self.tabloGoruntuleyici.estimatedRowHeight = 0;
        self.tabloGoruntuleyici.estimatedSectionHeaderHeight = 0;
        self.tabloGoruntuleyici.estimatedSectionFooterHeight = 0;
        
        VeriServisi.ornek.REF_GRUPLAR.observe(.value) { (snapshot) in
            VeriServisi.ornek.grupFeedleriniGetir(grup: self.grup!, sonuc: { (mesajlar) in
                self.mesajDizi=mesajlar;
                self.tabloGoruntuleyici.reloadData();
                if self.mesajDizi.count>0{
                    debugPrint("FKJLKFDJLKJLDFSKJLDFSKJKJLDFSKJLDFKJ \(self.mesajDizi.count-1)");
                    self.tabloGoruntuleyici.scrollToRow(at: IndexPath(row:self.mesajDizi.count-1,section:0), at: .none, animated: true);
                }
            })
        }
        
        
    }
    
    
    func initVeri(grup:Grup){
        self.grup=grup;
    }
    

    @IBAction func btnGeriBasildi(_ sender: Any) {
        dismissDetail();
    }
    
    @IBAction func btnGonderBasildi(_ sender: Any) {
        
        if txtMesaj.text != ""{
            txtMesaj.isEnabled=false;
            btnGonder.isEnabled=false;
            VeriServisi.ornek.feedPaylas(mesaj: txtMesaj.text!, kullaniciEposta: (Auth.auth().currentUser?.email)!, grupAnahtari: self.grup?.anahtar, kullaniciId: (Auth.auth().currentUser?.uid)!) { (sonuc) in
                if sonuc{
                    self.txtMesaj.isEnabled=true;
                    self.btnGonder.isEnabled=true;
                    self.txtMesaj.text="";
                }
            }
        }
        tabloGoruntuleyici.reloadData();
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

extension GrupFeedVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mesajDizi.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hucre=tableView.dequeueReusableCell(withIdentifier: TB_ID_GRUP_FEED_HUCRESI) as? GrupFeedHucresi
            else{return UITableViewCell();}
        
        let eposta=mesajDizi[indexPath.row].kullaniciEposta;
        let icerik=mesajDizi[indexPath.row].icerik;
        
        VeriServisi.ornek.profilResmiGetir(kullaniciId: mesajDizi[indexPath.row].kullaniciId) { (resim) in
            hucre.hucreleriAyarla(imgProfil: resim, eposta: eposta, icerik: icerik);

        }
        
        return hucre;
        
    }
    
    func klavyeyeBaglan(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(klavyeDegisince(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
    }
    
    @objc func klavyeDegisince(_ bildirim:NSNotification){
        print("OFDJSLELKJKSFJKJKFDJKSLFDLJKSLJDFLJKKJFDSKJLFDS");
        let sure=bildirim.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double;
        let sapma=bildirim.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt;
        
        let baslangicCercevesi=(bildirim.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue;
        let bitisCercevesi=(bildirim.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
        
        let deltaY=bitisCercevesi.origin.y-baslangicCercevesi.origin.y;
        klavyeUzunlugu=deltaY;
        self.bosluk.constant += klavyeUzunlugu;
        self.altbosluk.constant -= klavyeUzunlugu;
        UIView.animateKeyframes(withDuration: sure, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: sapma), animations: {
            self.view.layoutIfNeeded();
        }, completion: nil);
    }
}

