from flask import Flask, render_template
from flask_assets import Bundle, Environment
import os
import psycopg2
from dotenv import load_dotenv

load_dotenv(override=True)
app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(host= os.getenv('DB_HOST'),
                            database=os.getenv('DB_DATABASE'),
                            user=os.getenv('DB_USERNAME'),
                            password=os.getenv('DB_PASSWORD'),
                            port=os.getenv('DB_PORT'))
    return conn

@app.route('/')
def home():
    return "Hello, World!"

@app.route('/signin')
def signin():
    return render_template('signin.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != 'admin' or request.form['password'] != 'admin':
            error = 'Invalid Credentials. Please try again.'
        else:
            return redirect(url_for('home'))
    return render_template('login.html', error=error)

if __name__ == '__main__':
    app.run(debug=True)