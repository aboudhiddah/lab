from flask import jsonify
from . import db

@app.route('/')
def index():
    return jsonify({"message": "Hello, Dockerized Flask!"})
