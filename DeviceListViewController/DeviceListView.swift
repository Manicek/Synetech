//
// DeviceListView.swift
//
// Created by Patrik Hora


import UIKit
import SnapKit


class DeviceListView: UIView {
    
    let reloadButton = UIButton()
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: - Private extension

private extension DeviceListView {
    
    func addSubviews() {
        addSubviews(
            [
                reloadButton,
                tableView
            ]
        )
    }
    
    func setupSubviews() {
        reloadButton.setTitle("Load devices", for: .normal)
        reloadButton.layer.cornerRadius = 20
        reloadButton.backgroundColor = .orange
    }
    
    func setupConstraints() {
        reloadButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(48)
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(reloadButton.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().inset(8)
        }
    }
}
