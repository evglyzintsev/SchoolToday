from flask import Blueprint, request, Response, jsonify
from instance.database import db
from base64 import b64decode

module = Blueprint('gallery', __name__, url_prefix='/api/gallery')

@module.route('/add/label', methods=['POST'])
def label_add():
    args = request.args

    label = b64decode(args['label'])

    f = db.Gallery(
        gallery_label=label
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/add/image', methods=['POST'])
def image_id_add():
    args = request.args

    label = b64decode(args['image_id'])

    f = db.Gallery(
        gallery_image_id=image_id
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/get_images', methods=['POST', 'GET'])
def get_achivment():
    args = request.args
    label = args['label']

    query = db.Gallery.query.filter(Gallery.label == label).first()
    return query.image_id