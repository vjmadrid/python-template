"""This module does blah blah."""
from flask import Flask


app = Flask(__name__)


@app.route("/")
def get_hello_world():
    """This method does blah blah."""
    return "Hello World !!!"


@app.route('/user', defaults={'name': 'Crack'})
@app.route('/user/<name>')
def get_hello_user(name):
    """This method does blah blah."""
    return 'Hello {}'.format(name)


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000, debug=True)
