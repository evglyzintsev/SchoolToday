from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Users(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    name = db.Column(db.Text, nullable=False)
    cellular = db.Column(db.Text)
    mail = db.Column(db.Text)
    status = db.Column(db.Text, nullable=False)
    pass_hash = db.Column(db.Text, nullable=False)

class Feed(db.Model):
    __tablename__ = 'feed'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    author = db.Column(db.Integer, db.ForeignKey(Users.id), nullable=False)
    text = db.Column(db.Text, nullable=False)
    date = db.Column(db.Text, nullable=False)
    imageurl = db.Column(db.Text, nullable=False)
    post = db.Column(db.Text, nullable=False)

class Achivments(db.Model):
    __tablename__ = 'achivments'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    achivment_text = db.Column(db.Text, nullable=False)
    text = db.Column(db.Text, nullable=False)
    type = db.Column(db.Text, nullable=False)
    place = db.Column(db.Text, nullable=False)
    date = db.Column(db.Text, nullable=False)
    imageurl = db.Column(db.Text, nullable=False)

class Recomendations(db.Model):
    __tablename__ = 'recomendations'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    author = db.Column(db.Integer, db.ForeignKey(Users.id), nullable=False)
    text = db.Column(db.Text, nullable=False)
    date = db.Column(db.Text, nullable=False)
    
class Images(db.Model):
    __tablename__ = 'image'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    image_bin = db.Column(db.Text, nullable=False)

class Gallery(db.Model):
    __tablename__ = 'gallery'

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    label = db.Column(db.Text, nullable=False)
    image_id = db.Column(db.Integer, db.ForeignKey(Images.id))