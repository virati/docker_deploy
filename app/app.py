from distutils.log import error
from flask import Flask, request
import json

app = Flask(__name__)

description = """
                <!DOCTYPE html>
                <head>
                <title>API Landing</title>
                </head>
                <body>  
                    <h3>A simple API using Flask</h3>
                    <a href="http://172.17.0.3:5000/api?value=2">sample request</a>
                </body>
                """


@app.route("/", methods=["GET"])
def welcome_message():
    return description


@app.route("/api", methods=["GET"])
def square():
    if not all(k in request.args for k in (["value"])):
        error_message = f"aa"

        return error_message

    else:
        value = float(request.args["value"])
        value = request.args.get("value", type=float)
        return json.dumps({"Value Squared": value**2})


if __name__ == "__main__":
    from waitress import serve

    # serve(app, host="0.0.0.0", port=5000)
    app.run(host="0.0.0.0", port=5000)
