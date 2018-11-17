from flask import Blueprint, request, Response, jsonify, render_template
from instance.database import db

module = Blueprint('interface', __name__, url_prefix='')


@module.route('/main', methods=['GET', 'POST'])
def main():
    if request.method == 'GET':
        return render_template('MainMenuP.html')
    elif request.method == 'POST':
        pass


@module.route('/time_table', methods=['GET', 'POST'])
def time_table():
    if request.method == 'GET':
        return render_template('TimeTableP.html')
    elif request.method == 'POST':
        pass
