movies = [
    {:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'},
    {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989' },
    {:title => 'The Help', :rating => 'PG-13', :release_date => '12-Jun-1981' },
    {:title => 'Fight Club', :rating => 'R', :release_date => '21-Dec-1999' }
]

movies.each do |m|
    Movie.create!(m)
end