from flask import Flask
from flask.json import jsonify

from src.containers.views import register
from src.extensions import db, migrate

app = Flask(__name__)
app.config.from_object('config')

db.init_app(app)
migrate.init_app(app, db)


@app.route('/ping')
def ping():
    return jsonify({"data": "pong"})


register(app)
