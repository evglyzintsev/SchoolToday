function raa(){
    var tbl = '{"subject":"Русский","food":false,"plase": 409,"comment":"Yarik"}';
    tbl = json.parse(tbl);
    for (var key = 0; key < json.lenght; key++) {
        document.getElementById('nrop').innerHTML = tbl[key];
    }
}