from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()

class Users(db.Model):
	__tablename__ = 'users'

	id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False),
	name = db.Column(db.Text, nullable=False),
	cellular = db.Column(db.Text),
	mail = db.Column(db.Text),
	status = db.Column(db.Text, nullable=False),
	pass_hash = db.Column(db.Text, nullable=False)

class Feed(db.Model):
	__tablename__ = 'feed'

	id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
	author = db.Column(db.Integer, db.ForeignKey(Users.id), nullable=False),
	text = db.Column(db.Text, nullable=False),
	date = db.Column(db.Text, nullable=False),
	imageurl = db.Column(db.Text, nullable=False),
	post = db.Column(db.Text, nullable=False)
