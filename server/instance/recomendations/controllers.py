from flask import Blueprint, request, Response, jsonify
from instance.database import db

module = Blueprint('recomendations', __name__, url_prefix='/api/recomendations')

@module.route('/add', methods=['GET', 'POST'])
def recomendations_add():
    args = request.args

    author = args['author']
    text = args['text']
    date = args['date']
    
    f = db.Recomendations(
        recomendations_author=author,
        recomendations_text=text,
        recomendations_date=date,
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/get_recomendations', methods=['GET'])
def recomendations_feed():
    query = db.Recomendations.query.all()
    ans = []

    for entry in query:
        ans.append(entry.serialize())

    return jsonify({
        'values': ans
    })