from flask import Flask, render_template, request, redirect, url_for
from flask_assets import Bundle, Environment
from dotenv import load_dotenv
from flask_login import LoginManager,login_user,login_required, logout_user
from user import User
from database import get_db_connection

load_dotenv(override=True)
app = Flask(__name__)
app.secret_key = 'the random string'

login_manager = LoginManager()
login_manager.login_view = 'login'
login_manager.init_app(app)

@login_manager.user_loader
def load_user(user_id):
    return User.get(user_id)

@login_manager.unauthorized_handler
def page_not_authorized():
    return render_template('not_authorized.html'), 401

@app.route('/ping')
def ping():
    return "Hello! I am running"

@app.route('/lock-ping')
@login_required
def lock_ping():
    return "Hello! I am logged in"

@app.route('/attraction')
def attraction():
    cur = get_db_connection().cursor()
    cur.execute('SELECT * FROM attraction;')
    attractions = cur.fetchall()
    cur.close()
    return render_template('attraction.html', attractions=attractions)

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        cur = get_db_connection().cursor()
        cur.execute('SELECT * FROM "user" WHERE email=\'{}\' and password=\'{}\';'.format(request.form['email'], request.form['password']))
        user = cur.fetchone()
        if not user:
            error = 'Invalid Credentials. Please try again.'
        else:
            user = User(user[0],user[1],user[2],user[3])
            login_user(user)
            return redirect(url_for('attraction'))
    return render_template('login.html', error=error)

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True)