//
//  MovieListCell.swift
//  Cineaste
//
//  Created by Felizia Bernutz on 06.12.17.
//  Copyright © 2017 notimeforthat.org. All rights reserved.
//

import UIKit

class WantToSeeListCell: UITableViewCell {
    static let identifier = "WantToSeeListCell"

    @IBOutlet weak fileprivate var title: UILabel!
    @IBOutlet weak fileprivate var votes: UILabel!

    func configure(with movie: StoredMovie) {
        title.text = movie.title
        votes.text = "Votes: \(movie.voteAverage)"
    }
}