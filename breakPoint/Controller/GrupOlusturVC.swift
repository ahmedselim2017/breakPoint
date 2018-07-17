//
//  GrupOlusturVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 17.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit;
import Firebase;

class GrupOlusturVC: UIViewController {

    //Değişkenler
    var epostaDizi=[String]();
    var secilmisKisilerDizi=[String]();
    
    // UI Elementleri
    @IBOutlet weak var txtBaslik: TxtGiris!
    @IBOutlet weak var txtAciklama: TxtGiris!
    @IBOutlet weak var txtKatilimcilar: TxtGiris!
    
    @IBOutlet weak var lblKatilimcilar: UILabel!
    
    @IBOutlet weak var tabloGoruntuleyici: UITableView!
    
    @IBOutlet weak var btnGrupOlustur: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabloGoruntuleyici.delegate=self;
        tabloGoruntuleyici.dataSource=self;
        
        txtKatilimcilar.delegate=self;
        txtKatilimcilar.addTarget(self, action: #selector(txtKatilimciIcerikDegisti(_ :)), for: .editingChanged);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        btnGrupOlustur.isHidden=true;
    }
    
    @IBAction func btnGrupOlusturBasildi(_ sender: Any) {
        if txtBaslik.text != "" && txtAciklama.text != ""{
            
            secilmisKisilerDizi.append((Auth.auth().currentUser?.email)!);
            
            VeriServisi.ornek.grupOlustur(baslik: self.txtBaslik.text!, aciklama: self.txtAciklama.text!, kullaniciEpostalari: secilmisKisilerDizi, sonuc: { (durum) in
                if durum{
                    self.dismiss(animated: true, completion: nil);
                }
                else{
                    debugPrint("Hata 56")
                }
            })
            VeriServisi.ornek.kullaniciIdGetir(epostalar: secilmisKisilerDizi) { (idDizisi) in
                
            }
        }
    }
    
    @IBAction func btnGeriBasildi(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    @objc func txtKatilimciIcerikDegisti(_ txt:TxtGiris){
        debugPrint("AAAA");
        if txtKatilimcilar.text == ""{
            epostaDizi=[];
            tabloGoruntuleyici.reloadData();
        }
        else{
            VeriServisi.ornek.emailGetir(sorgu: txtKatilimcilar.text!) { (epostaDizi) in
                self.epostaDizi=epostaDizi;
                debugPrint("skdlşklsdklsaşd\(epostaDizi.count)")
                self.tabloGoruntuleyici.reloadData();
            }
        }
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
        debugPrint(self.epostaDizi.count);
        return self.epostaDizi.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        debugPrint("CCC");
        guard let hucre=tableView.dequeueReusableCell(withIdentifier: TB_ID_KULLANICI_HUCRESI) as? KullaniciHucresi else {debugPrint("DFKSJKFS");return UITableViewCell();}
        
        var secilmislik=false;
        let rsmProfil=UIImage(named:"defaultProfileImage");
        
        if secilmisKisilerDizi.contains(epostaDizi[indexPath.row]){
            secilmislik=true;
        }
        hucre.hucreleriAyarla(rsmProfil: rsmProfil!, eposta: epostaDizi[indexPath.row], secilmisMi: secilmislik);
        return hucre;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hucre=tableView.cellForRow(at: indexPath)as? KullaniciHucresi else{return;}
        if !(secilmisKisilerDizi.contains(hucre.lblEposta.text!)){
            secilmisKisilerDizi.append(hucre.lblEposta.text!);
            lblKatilimcilar.text=secilmisKisilerDizi.joined(separator: ", ");
            btnGrupOlustur.isHidden=false;
        }
        else{
            secilmisKisilerDizi=secilmisKisilerDizi.filter({$0 != hucre.lblEposta.text});
            if secilmisKisilerDizi.count>=1{
                lblKatilimcilar.text=secilmisKisilerDizi.joined(separator: ", ");
            }
            else{
                lblKatilimcilar.text="_katilimcilar";
                btnGrupOlustur.isHidden=true;
            }
        }
        tableView.reloadRows(at: [indexPath], with: .fade);
    }
}

extension GrupOlusturVC:UITextFieldDelegate{}
