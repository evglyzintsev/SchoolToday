function tableCreate(data) {
    var body = document.getElementById('nrop');
    var tbl = document.createElement('table');
    tbl.style.width = '100%';
    tbl.setAttribute('border', '1');
    var tbdy = document.createElement('tbody');
    for (var i = 0; i < 12; i++) {
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
            var dat = new Date;
            var day = dat.getDay();
            // console.log(data.ans[0, 0]);
            // document.getElementById('nrop').innerHTML = data.ans[0, 0];
            tableCreate(data.ans[day]);
        }
    });
}

window.onload = gtt;