import os
from random import choice
from string import ascii_uppercase
from flask import Flask,redirect

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello Flask!'

@app.route('/genkb/<size>')
def genkb(size):
    size=int(size)
    if size==0:
        return redirect("./redirect", code=302)
    else:
        return ''.join(choice(ascii_uppercase) for i in range(size*1024))

if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port,threaded=True)
