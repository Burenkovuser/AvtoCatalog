//
//  MainViewController.swift
//  AvtoCatalog
//
//  Created by Vasilii on 10/09/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    var carsList: Results<Car>! // коллекция всех данных с типом Car

    @IBAction func addButtonPressed(_ sender: Any) {
        alertForAddAndUpdateAvto()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsList = realmCar.objects(Car.self) // достаем из базы объекты типа Car
        
        
        if realmCar.isEmpty {
            loadCars()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell

        let carInfo = carsList[indexPath.row]
        cell.manufactureLabel.text = carInfo.manufacturer
        cell.modelLabel.text = carInfo.model
        cell.yaerLabel.text = carInfo.year
        cell.bodyTypeLabel.text = carInfo.bodyType

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func loadCars() {
        let car1 = Car()
        car1.manufacturer = "Audi"
        car1.model = "A3"
        car1.year = "2012"
        car1.bodyType = "Sedan"
        
        let car2 = Car(value: ["Audi", "A5", "2016", "Hatchback"])
        let car3 = Car(value: ["Audi", "RS 5", "2011", "Cabriolet"])
        
        DispatchQueue.main.async {
            StorageManager.SaveCar([car1, car2, car3])
        }
        
    }

}

extension MainViewController {
    
    private func alertForAddAndUpdateAvto() {
        
        let alert = UIAlertController(title: "Новый автомобиль", message: "Добавьте новый автомобиль", preferredStyle: .alert)
        var taskTextField: UITextField! //поменять названия
        var noteTextField: UITextField! //поменять названия
        var noteTextField1: UITextField! //поменять названия
        var noteTextField2: UITextField! //поменять названия
        
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let text = taskTextField.text , !text.isEmpty else { return }
            
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { textField in
            taskTextField = textField
            taskTextField.placeholder = "Производитель"
        }
        
        alert.addTextField { textField in
            noteTextField = textField
            noteTextField.placeholder = "Модель"
        }
        
        alert.addTextField { textField in
            noteTextField1 = textField
            noteTextField1.placeholder = "Год выпуска"
        }
        
        alert.addTextField { textField in
            noteTextField2 = textField
            noteTextField2.placeholder = "Тип кузова"
        }
        
        present(alert, animated: true)
    }
}
