from flask import Blueprint, request, Response
from .database import db

module = Blueprint('feed', __name__, url_prefix='/api/feed')

def resp(code, data):
	return Response(
			status=code
			response=jsonify(data)
		)

@module.route('/add', methods=['GET'])
@login_required
def feed_add():
	args = request.args

	author = args[author]
	text = args[text]
	date = args[date]
	imageurl = args[imageurl]#---TODO
	post = args[post]

	f = Feed(
			feed_author=author,
			feed_text=text,
			feed_date=date,
			feed_imageurl=image_url,
			feed_post=post
		)
	db.session.add(f)
	db.session.commit()
	resp(200, [])
