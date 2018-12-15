from flask import Blueprint, request, Response, jsonify
from instance.database import db

module = Blueprint('login', __name__, url_prefix='/api/login')

@module.route('', methods=['GET', 'POST'])
def user_login(login, password):
    logins = (Users
              .query
              .filter(Users.name == login)
              .all())
    if len(logins) != 1:
        return False
    user = logins[0]
    if check_password_hash(user.pass_hash, password):
        login_user(user)
        return True
    return False