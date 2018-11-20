from flask import Blueprint, request, Response, jsonify, render_template
from instance.database import db

module = Blueprint('interface', __name__, url_prefix='')

@module.route('/main', methods=['GET', 'POST'])
def main():
    if request.method == 'GET':
        return render_template('MainMenuP.html')
    elif request.method == 'POST':
        pass

@module.route('/time_table', methods=['GET', 'POST'])
def time_table():
    if request.method == 'GET':
        return render_template('TimeTableP.html')
    elif request.method == 'POST':
        pass

@module.route('/auth', methods=['GET', 'POST'])
def auth():
    if request.method == 'GET':
        return render_template('Authorization.html')
    elif request.method == 'POST':
        pass

@module.route('/school_event/add', methods=['GET', 'POST'])
def school_event_add():
    if request.method == 'GET':
        return render_template('add_school_event.html')
    elif request.method == 'POST':
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