from flask import Blueprint, request, Response, jsonify
from instance.database import db
from base64 import b64decode

module = Blueprint('images', __name__, url_prefix='/api/images')

@module.route('/add', methods=['POST'])
def achivment_add():
    args = request.args

    image_bin = b64decode(args['image_base64'])

    f = db.Images(
        images_image_bin=image_bin
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/get_image', methods=['POST', 'GET'])
def get_achivment():
    args = request.args
    image_id = args['id']

    query = db.Images.query.filter(Images.id == image_id).first()
    return query.image_bin