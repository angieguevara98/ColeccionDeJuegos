//
//  JuegoViewController.swift
//  ColeccionDeJuegos
//
//  Created by Angie Guevara  on 26/09/18.
//  Copyright © 2018 Tecsup. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var agregarActualizarboton: UIButton!
    
    @IBOutlet weak var eliminarboton: UIButton!
    var juego : Juego? = nil
    
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var TituloTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil{
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            TituloTextField.text = juego!.titulo
            agregarActualizarboton.setTitle("Actualizar", for: .normal)
        }
        else{
            eliminarboton.isHidden = true
        }
    }

    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageSeleccionada = info[UIImagePickerControllerOriginalImage] as! UIImage
        JuegoImageView.image =  imageSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func camaraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil{
            juego!.titulo = TituloTextField.text
            juego!.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = TituloTextField.text
            juego.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
        
    }
    

}
