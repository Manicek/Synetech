//
// DownloadDeviceListService.swift
//
// Created by Patrik Hora


import Foundation


class DownloadDeviceListService {
    
    // Force unwrapped because with URLs it is safe as long as you actually try it
    private let url = URL(string: "https://stub.bbeight.synetech.cz/demo/v2/homes/1/devices?username=demoday&password=synetech123")!
    var task: URLSessionDownloadTask?
    
    func callAsFunction(completionHandler: @escaping ([Device]?) -> Void) {
        print("Downloading device list")
        task = URLSession.shared.downloadTask(with: url) { localUrl, urlResponse, error in
            if let error = error {
                print("Error: Failed to download devices with error - \(error.localizedDescription)")
                completionHandler(nil)
                return
            }
            
            let decoder = JSONDecoder()
            guard let localUrl = localUrl, let data = try? Data(contentsOf: localUrl) else {
                print("Error: Cannot unpack localUrl - \(String(describing: localUrl))")
                return
            }

            if let deviceDTOs = try? decoder.decode([DeviceDTO].self, from: data) {
                print("Success: Downloaded devices - \(deviceDTOs)")
                completionHandler(deviceDTOs.map { Device.fromDTO($0) } )
            } else {
                print("Error: Decoding failed")
                completionHandler(nil)
            }
        }

        task?.resume()
    }
}
