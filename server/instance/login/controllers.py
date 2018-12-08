from flask import Blueprint, url_for, redirect, flash, render_template, request
from flask_login import current_user, login_user, logout_user, LoginManager, login_required
from ..database import Users
from .forms import LoginForm
from werkzeug.security import check_password_hash

lm = LoginManager()

module = Blueprint('login', __name__, url_prefix='')

@lm.user_loader
def load_user(user_id):
    return Users.get(user_id)

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

@module.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if user_login(request.form['login'], request.form['password']):
            return "YES"
        else:
            return "NO"
    
    form = LoginForm(request.form)
    return render_template(
        "authorization.html",
        form=form
    )


@module.route('/username', methods=['GET'])
@login_required
def username():
    return current_user.login
