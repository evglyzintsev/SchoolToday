from flask import Blueprint, request, Response, jsonify
from instance.database import db

module = Blueprint('achivments', __name__, url_prefix='/api/achivments')

@module.route('/add', methods=['GET', 'POST'])
def achivment_add():
    args = request.args

    achivment_text = args['achivment_text']
    text = args['text']
    date = args['date']
    imageurl = args['imageurl']  # ---TODO
    
    f = db.Achivments(
        achivments_achivment_text=achivment_text,
        achivments_text=text,
        achivments_date=date,
        achivments_imageurl=imageurl
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/get_achivments', methods=['GET'])
def get_achivment():
    query = db.Achivments.query.all()
    ans = []

    for entry in query:
        ans.append(entry.serialize())

    return jsonify({
        'values': ans
    })