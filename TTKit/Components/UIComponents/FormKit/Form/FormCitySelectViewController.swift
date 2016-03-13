//
//  FormCitySelectViewController.swift
//  testTableView
//
//  Created by tanson on 16/1/4.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class City {
    var name:String
    var areas = [String]()
    init (data:[String:AnyObject]){
        name = data["city"] as! String
        let areasData = data["areas"] as! [String]
        for area in areasData {
            self.areas.append(area)
        }
    }
}

class Province {
    var name:String
    var cites = [City]()
    
    init(data:[String:AnyObject]){
        name = data["state"] as! String
        
        let citysData = data["cities"] as! [[String:AnyObject]]
        for cityData in citysData {
            let city = City(data: cityData)
            self.cites.append(city)
        }
    }
    
}

class FormCitySelectViewController: FormViewController {

    var tag = 0
    var curProvince:String?
    var curCity:String?
    var curArea:String?
    var parentController:UIViewController?
    
    var cityDidSelect:((String,String,String?)->Void)?
    
    lazy var chinaProvinces:[[String:AnyObject]]? = {
        
        let data = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("area", ofType: "plist")!)
        
        return data as? [[String:AnyObject]]
    }()
    
    lazy var provinces:[Province] = {
        
        var ret = [Province]()
        
        if let proData = self.chinaProvinces {
            for pro in proData {
                let province = Province(data: pro)
                ret.append(province)
            }
        }
        return ret
        
    }()
    
    private func getCurProvince() ->Province? {
        for pro in self.provinces {
            if pro.name == self.curProvince {
                return pro
            }
        }
        return nil
    }
    private func getCurCity()->City?{
        if let pro = self.getCurProvince(){
            let citys = pro.cites
            for city in citys {
                if city.name == self.curCity {
                    return city
                }
            }
        }
        return nil
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func buildCells(builder: FormBuilder) {
        
        builder += FormSection()
        
        if tag == 0 {
            for pro in self.provinces{
                let cell = FormButtonCell(title:pro.name , rightText:"")
                cell.accessoryType = .DisclosureIndicator
                cell.action = {[weak self] cell in
                    let vc = FormCitySelectViewController()
                    vc.curProvince = pro.name
                    vc.tag = 1
                    vc.title = pro.name
                    vc.parentController = self?.parentController
                    vc.cityDidSelect = self?.cityDidSelect
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                builder += cell
            }
        }else if tag == 1 {
            
            if let pro = self.getCurProvince(){
                let citys = pro.cites
                
                for city in citys{
                    
                    let cell = FormButtonCell(title:city.name ,rightText:"")
                    
                    if city.areas.count > 0 {
                        cell.accessoryType = .DisclosureIndicator
                    }else{
                        cell.accessoryType = .None
                    }
                    
                    cell.action = {[weak self] cell in
                        self?.curCity = city.name
                        
                        if let currentCity = self!.getCurCity(){
                            if currentCity.areas.count > 0 {
                                let vc = FormCitySelectViewController()
                                vc.curProvince = self?.curProvince
                                vc.curCity = city.name
                                vc.title = city.name
                                vc.tag = 2
                                vc.parentController = self?.parentController
                                vc.cityDidSelect = self?.cityDidSelect
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }else{
                                
                                if let block = self?.cityDidSelect {
                                    block((self?.curProvince)!,(self?.curCity)!,nil)
                                }
                                self?.navigationController?.popToViewController((self?.parentController)!, animated: true)
                            }
                        }
                        
                    }
                    builder += cell
                }
            }
            
        }else if tag == 2 {
            
            if let city = self.getCurCity(){
                let areas = city.areas
                for area in areas {
                    let cell = FormButtonCell(title:area ,rightText: "")
                    
                    cell.action = {[weak self] cell in
                        
                        if let obj = self {
                            
                            if let block = obj.cityDidSelect {
                                block((self?.curProvince)!,(self?.curCity)!,area)
                            }
                            obj.navigationController?.popToViewController((self?.parentController)!, animated: true)
                            
                        }
                        
                    }
                    
                    builder += cell
                }
            }
        }
    }

   
}
