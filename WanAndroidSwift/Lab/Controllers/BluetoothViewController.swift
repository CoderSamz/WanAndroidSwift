//
//  BluetoothViewController.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 参考https://www.kodeco.com/231-core-bluetooth-tutorial-for-ios-heart-rate-monitor
    

import UIKit
import CoreBluetooth

class BluetoothViewController: UIViewController {

    @IBOutlet weak var bodySensorLocationLabel: UILabel!
    
    @IBOutlet weak var heartRateLabel: UILabel!
    var centralManager: CBCentralManager!
    var heartRatePeripheral: CBPeripheral!
    let heartRateServiceCBUUID = CBUUID(string: "0x180D")
    let healthThermometerServiceCBUUID = CBUUID(string: "0x1809")
    let heartRateMeasurementCharacteristicCBUUID = CBUUID(string: "2A37")
    let bodySensorLocationCharacteristicCBUUID = CBUUID(string: "2A38")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }

}

extension BluetoothViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unknown:
                print("central.state is .unknown")
            case .resetting:
                print("central.state is .resetting")
            case .unsupported:
                print("central.state is .unsupported")
            case .unauthorized:
                print("central.state is .unauthorized")
            case .poweredOn:
                print("central.state is .poweredOn")
                centralManager.scanForPeripherals(withServices: [heartRateServiceCBUUID])
            case .poweredOff:
                print("central.state is .poweredOff")
            default:
                break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print(peripheral)
        heartRatePeripheral = peripheral
        heartRatePeripheral.delegate = self
        centralManager.stopScan()
        centralManager.connect(heartRatePeripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        heartRatePeripheral.discoverServices([heartRateServiceCBUUID])
    }
}

extension BluetoothViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }

        for service in services {
            print(service)
            print(service.characteristics ?? "characteristics are nil")
            peripheral.discoverCharacteristics(nil, for: service)
        }

    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }

          for characteristic in characteristics {
              
              print(characteristic)
              if characteristic.properties.contains(.read) {
                  print("\(characteristic.uuid): properties contains .read")
                  peripheral.readValue(for: characteristic)
              }
              if characteristic.properties.contains(.notify) {
                  print("\(characteristic.uuid): properties contains .notify")
                  peripheral.setNotifyValue(true, for: characteristic)
              }
              
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
            case bodySensorLocationCharacteristicCBUUID:
//                print(characteristic.value ?? "no value")
                let bodySensorLocation = bodyLocation(from: characteristic)
                bodySensorLocationLabel.text = bodySensorLocation
            case heartRateMeasurementCharacteristicCBUUID:
                let bpm = heartRate(from: characteristic)
                heartRateLabel.text = String(bpm)
            default:
                print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
    }
    
    private func bodyLocation(from characteristic: CBCharacteristic) -> String {
        guard let characteristicData = characteristic.value,
              let byte = characteristicData.first else { return "Error" }

        switch byte {
            case 0: return "Other"
            case 1: return "Chest"
            case 2: return "Wrist"
            case 3: return "Finger"
            case 4: return "Hand"
            case 5: return "Ear Lobe"
            case 6: return "Foot"
            default:
                return "Reserved for future use"
        }
    }

    private func heartRate(from characteristic: CBCharacteristic) -> Int {
        guard let characteristicData = characteristic.value else { return -1 }
        let byteArray = [UInt8](characteristicData)

        let firstBitValue = byteArray[0] & 0x01
        if firstBitValue == 0 {
            // Heart Rate Value Format is in the 2nd byte
            return Int(byteArray[1])
        } else {
            // Heart Rate Value Format is in the 2nd and 3rd bytes
            return (Int(byteArray[1]) << 8) + Int(byteArray[2])
        }
    }

}
