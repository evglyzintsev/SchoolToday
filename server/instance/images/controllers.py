from flask import Blueprint, request, Response, jsonify
import json
from instance.database import db, Images
from base64 import b64decode

module = Blueprint('images', __name__, url_prefix='/api/images')

@module.route('/add', methods=['GET', 'POST'])
def achivment_add():
    args = request.form
    print(args['image_base64'])
    image_bin = b64decode(args['image_base64'][10:-2])
    f = Images(
        image_bin=image_bin
    )
    db.session.add(f)
    db.session.commit()

    query = db.session.query(Images).count()
    return str( query)


@module.route('/get_image', methods=['POST', 'GET'])
def get_achivment():
    args = request.form

    print(args['id'])
    image_id = args['id'][10:-2]
    print(image_id)
    query = (Images
              .query
              .filter(Images.id == image_id)
              .all())

    return query[0].image_bin
