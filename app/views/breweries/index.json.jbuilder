json.array!(@breweries) do |brewery|
    json.extract! brewery, :id, :name, :year, :active
    json.beers do
        json.no_beers brewery.beers.count
    end
end
