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
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let currentCar = carsList[indexPath.row] // объект для удаления
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (_, _) in
            StorageManager.deleteCar(currentCar)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
    
    // MARK: - Private funcs
    
    private func loadCars() {
        let car1 = Car()
        car1.manufacturer = "Audi"
        car1.model = "A3"
        car1.year = "2012"
        car1.bodyType = "Sedan"
        
        let car2 = Car(value: ["Audi", "A5", "2016", "Hatchback"])
        let car3 = Car(value: ["Audi", "RS 5", "2011", "Cabriolet"])
        
        DispatchQueue.main.async {
            StorageManager.SaveCars([car1, car2, car3])
        }
    }
}

extension MainViewController {
    
    private func alertForAddAndUpdateAvto() {
        
        let alert = UIAlertController(title: "Новый автомобиль", message: "Добавьте новый автомобиль", preferredStyle: .alert)
        var manufactureTextField: UITextField!
        var modelTextField: UITextField!
        var yearTextField: UITextField!
        var bodyTypeTextField: UITextField!
        
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let newManufacture = manufactureTextField.text , !newManufacture.isEmpty else { return }
            
            let car = Car()
            car.manufacturer = newManufacture
            car.model = modelTextField.text ?? ""
            car.year = yearTextField.text ?? ""
            car.bodyType = bodyTypeTextField.text ?? ""
            
            StorageManager.SaveCar(car)
            
            self.tableView.insertRows(at: [IndexPath(row: self.carsList.count - 1, section: 0)], with: .automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { textField in
            manufactureTextField = textField
            manufactureTextField.placeholder = "Производитель"
        }
        
        alert.addTextField { textField in
            modelTextField = textField
            modelTextField.placeholder = "Модель"
        }
        
        alert.addTextField { textField in
            yearTextField = textField
            yearTextField.placeholder = "Год выпуска"
        }
        
        alert.addTextField { textField in
            bodyTypeTextField = textField
            bodyTypeTextField.placeholder = "Тип кузова"
        }
        
        present(alert, animated: true)
    }
}
