function tableCreate(data) {
    var body = document.getElementById('nrop');
    var tbl = document.createElement('table');
    tbl.setAttribute('border', '10');
    var tbdy = document.createElement('tbody');
    for (var i = 1; i < 12; i++) {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        td.innerText = data[i];
        td.innerHTML += '<br>';
        tr.appendChild(td);
        tbdy.appendChild(tr);
    }
    tbl.appendChild(tbdy);
    body.appendChild(tbl)
}

function gtt() {
    $.ajax({
        url: 'http://127.0.0.1:5000/api/schedule/get_schedule/6C',
        success: function (data) {
            data = JSON.parse(data);
            console.log(data.ans[0, 0]);
            //  document.getElementById('nrop').innerHTML = data.ans[0, 0];
            tableCreate(data.ans[0]);
            var dat = new Date;
            var day = dat.getDay();
            // console.log(data.ans[0, 0]);
            // document.getElementById('nrop').innerHTML = data.ans[0, 0];
            tableCreate(data.ans[day]);
        }
    });
}

window.onload = gtt;