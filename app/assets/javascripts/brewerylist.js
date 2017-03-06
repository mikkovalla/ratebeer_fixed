var BREWERIES = {};

BREWERIES.show = function() {
    $("#brewerytable tr:gt(0)").remove();

    var table = $("#brewerytable");

    $.each(BREWERIES.list, function(index, brewery) {
        table.append('<tr>' +
            '<td>' + brewery['name'] + '</td>' +
            '<td>' + brewery['year'] + '</td>' +
            '<td>' + brewery['beers']['no_beers'] + '</td>' +
            '<td>' + brewery['active'] + '</td>' +
            '</tr>');
    });
};

BREWERIES.sort_by_name = function() {
    BREWERIES.list.sort(function(a, b) {
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function() {
    BREWERIES.list.sort(function(a, b) {
        return a.year < (b.year);
    });
};

BREWERIES.sort_by_no_beers = function() {
    BREWERIES.list.sort(function(a, b) {
        return a.beers.no_beers < b.beers.no_beers;
    });
};

BREWERIES.sort_by_active = function() {
    BREWERIES.list.sort(function(a, b) {
        return a.active < b.active;
    });
};

$(document).ready(function() {
    if ($("#brewerytable").length > 0) {

        $("#name").click(function(e) {
            BREWERIES.sort_by_name();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#year").click(function(e) {
            BREWERIES.sort_by_year();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#no_beers").click(function(e) {
            BREWERIES.sort_by_no_beers();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#active").click(function(e) {
            BREWERIES.sort_by_active();
            BREWERIES.show();
            e.preventDefault();
        });


        $.getJSON('breweries.json', function(breweries) {
            BREWERIES.list = breweries;
            BREWERIES.sort_by_name;
            BREWERIES.show();
        });

    }
});
