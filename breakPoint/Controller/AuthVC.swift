//
//  AuthVC.swift
//  breakPoint
//
//  Created by Ahmed Selim Üzüm on 14.07.2018.
//  Copyright © 2018 Ahmed Selim Üzüm. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func epostaIleGirisYapBasildi(_ sender: Any) {
        let girisYapVC=storyboard?.instantiateViewController(withIdentifier: SB_ID_GirisYapVC);
        present(girisYapVC!, animated: true, completion: nil);
    }
    
    @IBAction func facebookIleGirisYapBasildi(_ sender: Any) {
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
