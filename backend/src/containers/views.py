from flask import jsonify
from flask_classful import FlaskView


class ContainerView(FlaskView):
    def get(self, id):
        return jsonify({"data": id})


def register(app_inst):
    ContainerView.register(app_inst, route_base='containers')
