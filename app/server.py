import flask, json, sqlite3, bcryptimport threadingfrom flask import render_template, send_file, jsonify, abort, make_response, request, redirect, url_for, send_from_directoryfrom flask import Flaskimport osfrom .config import *app = flask.Flask(__name__)@app.route('/api/login', strict_slashes=False, methods=['GET', 'POST'])def login():    if flask.request.method == 'GET':        return flask.render_template('login.html')    elif flask.request.method == 'POST':        if len(flask.request.form["login"]) * len(flask.request.form["password"]) == 0:            return json.dumps({'successfull': False, 'errors': ['All fields are required']})        db = sqlite3.connect(school_db)        c = db.cursor()        c.execute('SELECT password FROM users WHERE login="{}"'.format(flask.request.form["login"]))        db_pass = c.fetchone()        db.close()        if (db_pass is not None) and bcrypt.checkpw(flask.request.form["password"].encode('utf-8'),                                                    db_pass[0].encode('utf-8')):            db = sqlite3.connect(school_db)            c = db.cursor()            c.execute('SELECT id FROM users WHERE login="{}"'.format(flask.request.form["login"]))            id = c.fetchone()[0]            c.execute('SELECT status FROM users WHERE login="{}"'.format(flask.request.form["login"]))            status = c.fetchone()[0]            db.close()            return json.dumps({'successfull': True, 'id': id, 'status': status})        else:            return json.dumps({'successfull': False, 'errors': ['Login or Password is incorrect']})@app.route('/api/school-events', strict_slashes=False, methods=['GET'])def school_events():    db = sqlite3.connect(school_db)    c = db.cursor()    c.execute('SELECT * FROM school_events')    ans_list = []    for i in c.fetchall():        ans_list.append({'id': i[0], 'date': i[1], 'time': i[2], 'tag': i[3], 'des': i[4], 'long': i[5], 'image': i[6]})    ans = json.dumps({'data': ans_list})    db.close()    return ans@app.route('/api/school-events/add/api/school-events/add', strict_slashes=False, methods=['GET', 'POST'])def school_events_add():    if flask.request.method == 'GET':        return flask.render_template('add_school_event.html')    elif flask.request.method == 'POST':        if len(flask.request.form["date"]) * len(flask.request.form["time"]) * len(flask.request.form["class"]) * len(flask.request.form["short_description"]) * len(flask.request.form["description"]) * len(flask.request.form["image"]) == 0:            return json.dumps({'successfull': False, 'errors': ['All fields are required']})        db = sqlite3.connect(school_db)        c = db.cursor()        c.execute('INSERT INTO school_events (date, time, type, short_description, description, image) VALUES ("{}", "{}", "{}", "{}", "{}", "{}");'.format(flask.request.form["date"][10:-2], flask.request.form["time"][10:-2], flask.request.form["class"][10:-2], flask.request.form["short_description"][10:-2], flask.request.form["description"][10:-2], flask.request.form["image"]))        db.commit()        db.close()        return json.dumps({'successfull': True})@app.route('/api/school-events/delete', strict_slashes=False, methods=['GET', 'POST'])def school_events_delete():    if flask.request.method == 'GET':        return flask.render_template('delete_school_event.html')    elif flask.request.method == 'POST':        db = sqlite3.connect(school_db)        c = db.cursor()        c.execute('DELETE FROM school_events WHERE date="{}" AND time="{}" AND type="{}" AND short_description="{}" AND description="{}" AND image="{}";'.format(flask.request.form["date"], flask.request.form["time"], flask.request.form["class"], flask.request.form["short_description"], flask.request.form["description"], flask.request.form["image"]))        db.commit()        db.close()        return json.dumps({'successfull': True})@app.route('/api/achivments', strict_slashes=False, methods=['GET'])def achivments():    db = sqlite3.connect(school_db)    c = db.cursor()    c.execute('SELECT * FROM achivments')    ans_list = []    for i in c.fetchall():        ans_list.append({'id': i[0], 'date': i[1], 'place': i[2], 'des': i[3], 'long': i[4], 'image': i[5]})    ans = json.dumps({'data': ans_list})    db.close()    return ans@app.route('/api/photos', strict_slashes=False, methods=['GET'])def photos():    print(os.listdir())    db = sqlite3.connect(school_db)    c = db.cursor()    c.execute('SELECT * FROM Photo')    ans_list = []    for i in c.fetchall():        ans_list.append({'image': i[0]})    ans = json.dumps({'data': ans_list})    db.close()    return ans@app.route('/api/photos/add', strict_slashes=False, methods=['GET', 'POST'])def photos_add():    if flask.request.method == 'GET':        return flask.render_template('photos_adder.html')    else:        db = sqlite3.connect(school_db)        c = db.cursor()        c.execute(            'INSERT INTO Photo (image) VALUES ("{}");'.format(                flask.request.form["date"]))        db.commit()        db.close()        return json.dumps({'successfull': True})@app.route('/api/achivments/add', strict_slashes=False, methods=['GET', 'POST'])def achivments_add():    if flask.request.method == 'GET':        return flask.render_template('add_achivment.html')    elif flask.request.method == 'POST':        if len(flask.request.form["date"]) * len(flask.request.form["place"]) * len(flask.request.form["short_description"]) * len(flask.request.form["description"]) * len(flask.request.form["image"]) == 0:            return json.dumps({'successfull': False})        db = sqlite3.connect(school_db)        c = db.cursor()        c.execute('INSERT INTO achivments (date, place, short_description, description, image) VALUES ("{}", "{}", "{}", "{}", "{}");'.format(flask.request.form["date"][10:-2], flask.request.form["place"][10:-2], flask.request.form["short_description"][10:-2], flask.request.form["description"][10:-2], flask.request.form["image"]))        db.commit()        db.close()        return json.dumps({'successfull': True})@app.route('/api/achivments/delete', strict_slashes=False, methods=['GET', 'POST'])def achivments_delete():    if flask.request.method == 'GET':        return flask.render_template('delete_achivment.html')    elif flask.request.method == 'POST':        db = sqlite3.connect(school_db)        c = db.cursor()        c.execute('DELETE FROM achivments WHERE date="{}" AND place="{}" AND short_description="{}" AND description="{}" AND image="{}";'.format(flask.request.form["date"], flask.request.form["place"], flask.request.form["short_description"], flask.request.form["description"], flask.request.form["image"]))        db.commit()        db.close()        return json.dumps({'successfull': True})@app.route('/api/birthday', strict_slashes=False, methods=['GET', 'POST'])def birthday():    db = sqlite3.connect(school_db)    c = db.cursor()    c.execute('SELECT * FROM Birhtdays')    ans_list = []    for i in c.fetchall():        ans_list.append({'name': i[0], 'date': i[1]})    ans = json.dumps({'data': ans_list})    return ans@app.route('/api/olymps', strict_slashes=False, methods=['GET', 'POST'])def olymps():    db = sqlite3.connect(school_db)    c = db.cursor()    c.execute('SELECT * FROM Olymps')    ans_list = []    for i in c.fetchall():        ans_list.append({'Date': i[0], 'des': i[1], 'place': i[2], 'Start': i[3], 'end': i[4]})    ans = json.dumps({'data': ans_list})    return ans@app.route('/admin/users', strict_slashes=False, methods=['GET', 'POST'])def users_4_admin():    if flask.request.method == 'GET':        return flask.render_template('view_users.html')    elif flask.request.method == 'POST':        if admin_code_users_view == flask.request.form["code"]:            db = sqlite3.connect(school_db)            c = db.cursor()            c.execute('SELECT * FROM users')            ans = json.dumps(c.fetchall())            db.close()            return ans        else:            return json.dumps({'successfull': False, 'errors': ['Code isn`t correct)))']})@app.route('/admin/users/add', strict_slashes=False, methods=['GET', 'POST'])def add_4_admin():    if flask.request.method == 'GET':        return flask.render_template('add_user.html')    elif flask.request.method == 'POST':        if len(flask.request.form["code"]) * len(flask.request.form["login"]) * len(                flask.request.form["password"]) * len(flask.request.form["status"]) == 0:            return json.dumps({'successfull': False, 'errors': ['All fields are required']})        if admin_code_add_user == flask.request.form["code"]:            login = flask.request.form["login"]            password = flask.request.form["password"]            password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')            status = flask.request.form["status"]            db = sqlite3.connect(school_db)            c = db.cursor()            c.execute('INSERT INTO users (login, password, status) VALUES ("{}", "{}", "{}");'.format(login, password,                                                                                                      status))            db.commit()            db.close()            return json.dumps({'successfull': True})        else:            return json.dumps({'successfull': False, 'errors': ['Code isn`t correct)))']})@app.route('/admin/users/delete', strict_slashes=False, methods=['GET', 'POST'])def del_4_admin():    if flask.request.method == 'GET':        return flask.render_template('delete_user.html')    elif flask.request.method == 'POST':        if len(flask.request.form["code"]) * len(flask.request.form["id"]) == 0:            return json.dumps({'successfull': False, 'errors': ['All fields are required']})        if admin_code_delete_user == flask.request.form["code"]:            db = sqlite3.connect(school_db)            c = db.cursor()            c.execute('DELETE FROM users WHERE id=("{}");'.format(flask.request.form["id"]))            db.commit()            db.close()            return json.dumps({'successfull': True})        else:            return json.dumps({'successfull': False, 'errors': ['Code isn`t correct)))']})app.run(host='0.0.0.0', port='5000')