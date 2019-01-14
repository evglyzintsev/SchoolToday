from flask import Blueprint, request, Response, jsonify
from instance.database import db, Users
import json
module = Blueprint('api_login', __name__, url_prefix='/api/login')

@module.route('', methods=['GET', 'POST'])
def user_login():
    args = request.form
    login = args['login']
    password = args['password']

    logins = (Users
              .query
              .filter(Users.name == login)
              .all())

    if len(logins) != 1:
        return "neOK"
    user = logins[0]
    #if check_password_hash(user.pass_hash, password):
    #    login_user(user)
    #    return "OK"
    print(user.status)
    if user.pass_hash == password:
        #login_user(user)
        return user.status
    return "neOK"
@module.route('get_info', methods=['POST'])
def user_info():
    args = request.form
    login = args['login']
    print(login)
    login = login[10:-2]
    logins = (Users.query.filter(Users.name == login).all())
    user = logins[0]
    return jsonify({"email" :  user.mail, "cellular" :  user.cellular})

