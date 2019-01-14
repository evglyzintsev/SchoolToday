from flask import Blueprint, request, Response, jsonify
from instance.database import db, Feed

module = Blueprint('feed', __name__, url_prefix='/api/feed')

@module.route('/add', methods=['GET', 'POST'])
def feed_add():
    args = request.form
    author = args['author']
    text = args['text']
    date = args['date']
    imageurl = args['imageurl']  # ---TODO
    post = args['post']

    f = Feed(
        author=author,
        text=text,
        date=date,
        imageurl=imageurl,
        post=post
    )
    db.session.add(f)
    db.session.commit()
    return "OK"


@module.route('/get_feed', methods=['GET'])
def get_feed():
    query = db.session.query(Feed)
    ans = {"images" : [], "text": [], "date" : []}


    for entry in query:
        ans['images'].append(entry.imageurl)
        ans['text'].append(entry.text[10:-2])
        ans['date'].append(entry.date)
	
    ans['images'] = ans['images'][::-1]
    ans['text'] = ans['text'][::-1]
    ans['date'] = ans['date'][::-1]
    return jsonify({
        'values': ans
    })
