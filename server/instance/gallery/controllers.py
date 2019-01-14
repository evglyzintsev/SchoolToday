from flask import Blueprint, request, Response, jsonify
import json
from instance.database import db, Gallery
from base64 import b64decode

module = Blueprint('gallery', __name__, url_prefix='/api/gallery')

@module.route('/add/label', methods=['GET', 'POST'])
def label_add():
    args = request.form
    new_label = args['label'][10:-2]

    f = Gallery(
        label=new_label,
        image_id=''
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


def insert (source_str, insert_str, pos):
    return source_str[:pos]+insert_str+source_str[pos:]

@module.route('/add/image', methods=['POST'])
def image_id_add():
    args = request.form

    labelss = args['image_id']
    labels = args['label'][10:-2]
    query = (Gallery
          .query
          .filter(Gallery.label == labels)
          .all())
    images = query[0].image_id
    images = insert(images,',' + labelss + ',' , len(images) - 1)
    gal = db.session.query(Gallery).filter_by(label=labels).first()
    gal.image_id = images
    db.session.commit()
    return "OK"


@module.route('/get_images', methods=['POST', 'GET'])
def get_image():
    args = request.form
    labels= args['label']
    query = db.session.query(Gallery).filter_by(label=labels).first()
    print(query.image_id)
    return query.image_id

@module.route('/list', methods=['POST', 'GET'])
def get_label():
    query = db.session.query(Gallery.label)
    ans = []
    for i in query:
        ans.append(i[0])

    return json.dumps({'data': ans})
