from flask import Blueprint, request, Response, jsonify
from instance.database import db

module = Blueprint('schedule', __name__, url_prefix='/api/schedule')


@module.route('/get_schedule', methods=['GET'])
def get_schedule():
    pass  # TODO
