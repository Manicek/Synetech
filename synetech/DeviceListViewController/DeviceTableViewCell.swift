//
// DeviceTableViewCell.swift
//
// Created by Patrik Hora


import UIKit


class DeviceTableViewCell: UITableViewCell {
    
    static let identifer = String(describing: self)
    
    // MARK: - Properties
    
    private let deviceImageView = UIImageView()
    private let serialNumberLabel = UILabel()
    private let batteryImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - Internal extension

extension DeviceTableViewCell {
    
    func setup(_ device: Device) {
        deviceImageView.image = device.image
        serialNumberLabel.text = device.serialNumber
        batteryImageView.isHidden = !device.isBatteryLow
    }
}


// MARK: - Private extension

private extension DeviceTableViewCell {
    
    func addSubviews() {
        addSubviews(
            [
                deviceImageView,
                serialNumberLabel,
                batteryImageView
            ]
        )
    }
    
    func setupSubviews() {
        deviceImageView.contentMode = .scaleAspectFit
        
        serialNumberLabel.font = .systemFont(ofSize: 16)
        
        batteryImageView.image = Asset.lowBattery
    }
    
    func setupConstraints() {
        deviceImageView.snp.makeConstraints { make in
            // priority set just to silence UIView-Encapsulated-Layout-Height warning
            make.left.top.bottom.equalToSuperview().inset(12).priority(999)
            make.size.equalTo(32)
        }
        
        serialNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(deviceImageView.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        batteryImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(28)
        }
    }
}
