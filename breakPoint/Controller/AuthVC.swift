//
//  AuthVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 14.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit;
import Firebase;
import FBSDKLoginKit;
import GoogleSignIn;


class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if Auth.auth().currentUser != nil{
            dismissDetail();
        }
    }
    
    @IBAction func epostaIleGirisYapBasildi(_ sender: Any) {
        let girisYapVC=storyboard?.instantiateViewController(withIdentifier: SB_ID_GirisYapVC);
        presentDetail(girisYapVC!);
    }
    
    @IBAction func facebookIleGirisYapBasildi(_ sender: Any) {
        let girisYapVC=storyboard?.instantiateViewController(withIdentifier: SB_ID_GirisYapVC);
        AuthServisi.ornek.kullaniciGirisYap(viewController: self);
        self.dismissDetail();
        
    }
    
    @IBAction func btnAnonimOlarakGirisYapBasildi(_ sender: Any) {
        let girisYapVC=storyboard?.instantiateViewController(withIdentifier: SB_ID_GirisYapVC);
        AuthServisi.ornek.kullaniciGirisYap();
        self.dismissDetail();
    }
    
    @IBAction func googleIleGirisYapBasildi(_ sender: Any) {
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
