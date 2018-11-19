function raa() {
    var tbl = '{"subject":"Русский","food":false,"place": 409,"comment":"Yarik"}';
    tbl = JSON.parse(tbl);
    document.getElementById('nrop').innerHTML += tbl.subject;
    document.getElementById('nrop').innerHTML += tbl.food;
    document.getElementById('nrop').innerHTML += tbl.place;
    document.getElementById('nrop').innerHTML += tbl.comment;
    document.getElementById('nrop').appendChild;
}

function kyky() {
    jQuery.ajax({
        url: 'http://127.0.0.1:5000/api/schedule/get_schedule/5C',
        success: function () {
            alert('Load was performed.');
        }
    });
}