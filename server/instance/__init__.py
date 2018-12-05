from flask import Flask
from .database import db
from instance.login import lm

def create():
    SchoolToday = Flask(__name__, static_folder='static')
    SchoolToday.config.from_object('config')
    SchoolToday.config.from_pyfile('config.py')
    db.init_app(SchoolToday)
    lm.init_app(SchoolToday)
    with SchoolToday.test_request_context():
        db.create_all()

    import instance.feed as feed
    SchoolToday.register_blueprint(feed.module)
    import instance.schedule as schedule
    SchoolToday.register_blueprint(schedule.module)
    import instance.interface as interface
    SchoolToday.register_blueprint(interface.module)
    import instance.login as login
    SchoolToday.register_blueprint(login.module)
    import instance.achivments as achivments
    SchoolToday.register_blueprint(achivments.module)
    import instance.images as images
    SchoolToday.register_blueprint(images.module)
    import instance.gallery as gallery
    SchoolToday.register_blueprint(gallery.module)
    return SchoolToday