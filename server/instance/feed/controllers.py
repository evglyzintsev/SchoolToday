from flask import Blueprint, request, Response, jsonify
from instance.database import db

module = Blueprint('feed', __name__, url_prefix='/api/feed')


@module.route('/add', methods=['GET'])
def feed_add():
    args = request.args

    author = args['author']
    text = args['text']
    date = args['date']
    imageurl = args['imageurl']  # ---TODO
    post = args['post']

    f = db.Feed(
        feed_author=author,
        feed_text=text,
        feed_date=date,
        feed_imageurl=imageurl,
        feed_post=post
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/get_feed', methods=['GET'])
def get_feed():
    query = db.Feed.query.all()
    ans = []

    for entry in query:
        ans.append(entry.serialize())

    return jsonify({
        'values': ans
    })