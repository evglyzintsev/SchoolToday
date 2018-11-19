function raa(){
    var tbl = '{"subject":"Русский","food":false,"plase": 409,"comment":"Yarik"}';
    tbl = json.parse(tbl);
    for (var g in tbl) {
        document.getElementById('nrop').innerHTML = tbl[g];
    }
}