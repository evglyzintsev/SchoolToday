from flask import Blueprint, request, Response, jsonify
from instance.database import db, Achivments

module = Blueprint('achivments', __name__, url_prefix='/api/achivments')

@module.route('/add', methods=['GET', 'POST'])
def achivment_add():
    args = request.form

    text = args['text']
    date = args['date']
    place = args['place']
    imageurl = args['imageurl']  # ---TODO
    
    f = Achivments(
        achivment_text='',
        text=text,
        date=date,
        type='',
        place=place,
        imageurl=imageurl
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/get_achivments', methods=['GET'])
def get_achivment():
    query = db.session.query(Achivments)
    ans = {'images': [], 'text' : [], 'date' : [], 'place' : []}

    for entry in query:
        ans['images'].append(entry.imageurl)
        ans['text'].append(entry.text)
        ans['place'].append(entry.place)
        ans['date'].append(entry.date)
    ans['images'] = ans['images'][::-1]
    ans['text'] = ans['text'][::-1]
    ans['place'] = ans['place'][::-1]
    ans['date'] = ans['date'][::-1]

    return jsonify({
        'values': ans
    })
