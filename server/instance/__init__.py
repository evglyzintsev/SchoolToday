from flask import Flask
from .database import db


def create():
    SchoolToday = Flask(__name__)
    SchoolToday.config.from_object('config')
    SchoolToday.config.from_pyfile('config.py')
    db.init_app(SchoolToday)
    with SchoolToday.test_request_context():
        db.create_all()

    import instance.feed as feed
    SchoolToday.register_blueprint(feed.module)
    import instance.schedule as schedule
    SchoolToday.register_blueprint(schedule.module)
    return SchoolToday