//
//  Services.swift
//  KickerApp
//
//  Created by Phuong Nguyen on 15.01.19.
//  Copyright © 2019 Phuong Nguyen. All rights reserved.
//

import Alamofire
import Foundation

class FoosballService {
    static let shared = FoosballService()
    private let baseUrl = "http://azubisrv.jambit.com/api/sonic-sensors/status"
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    private init() {}

    func getKickerInfo(completionHandler: @escaping ([FoosballTableCodable]) -> Void) {
        Alamofire.request(baseUrl).responseJSON(queue: utilityQueue) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    guard let kickerInfo = self.parseKickerInfo(json: response.data) else {
                        return completionHandler([])
                    }
                    completionHandler(kickerInfo)
                    return
                }
            case .failure(let error):
                print(error)
                completionHandler([])
            }
        }
    }

    private func parseKickerInfo(json: Data?) -> [FoosballTableCodable]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let data = json, let jsonKickerInfo = try? decoder.decode([FoosballTableCodable].self, from: data) {
            return jsonKickerInfo
        }
        return nil
    }
}