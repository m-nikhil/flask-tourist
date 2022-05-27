from flask import Flask, render_template, request, redirect, url_for, flash
from flask_assets import Bundle, Environment
from dotenv import load_dotenv
from flask_login import LoginManager,login_user,login_required, logout_user, current_user
from user import User
from database import get_db_connection
import datetime
from pprint import pprint

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
    city = request.args.get('city') if request.args.get('city') else ''
    city_clause = 'and city = \'{}\''.format(city) if city else ''
    if 'date' in request.args and not request.args.get('date') == '':
        date = request.args.get('date')
    else:
        date = datetime.date.today().strftime('%m-%d-%Y')

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT * FROM day_attraction INNER JOIN attraction USING (attraction_id) where date=\'{}\' {};'.format(date, city_clause))
    attractions = cur.fetchall()

    # create day_attraction for a particular date if not populated yet
    if not attractions:

        cur.execute('SELECT * FROM day_attraction where date=\'{}\''.format(date))
        day_attraction = cur.fetchall()

        if not day_attraction:
            cur.execute('SELECT attraction_id FROM attraction')
            attraction_ids = cur.fetchall()

            for id in attraction_ids:
                cur.execute('INSERT INTO day_attraction (date,attraction_id,number_of_tickets_booked) VALUES (\'{}\',{},{});'.format(date, id[0], 0 ) )
                conn.commit()
            cur.execute('SELECT * FROM day_attraction INNER JOIN attraction USING (attraction_id) where date=\'{}\' {};'.format(date, city_clause))
            attractions = cur.fetchall()

    colnames = [desc[0] for desc in cur.description]
    attractions_dict = [ dict(zip(colnames,attraction)) for attraction in attractions ]
    cur.close()
    conn.close()
    pprint(date)
    return render_template('attraction.html', attractions=attractions_dict, date = date, city = city)

@app.route('/viewBookings')
@login_required
def viewBookings():
    pprint(str(current_user.get_id()) + current_user.name)
    conn = get_db_connection()
    cur = conn.cursor()
    sql = '''select bk.booking_id, bk.attraction_id, att.name attraction_spot, att.description, att.address, att.price_per_ticket, bk.number_of_tickets,
                bk.date_of_booking, bk.status from booking bk
                inner join "user" usr
                on bk.user_id = usr.user_id
                inner join attraction att
                on bk.attraction_id = att.attraction_id 
                where bk.user_id = \'{}\' '''.format(current_user.get_id())
    pprint(sql)
    cur.execute(sql)
    bookings = cur.fetchall()

    colnames = [desc[0] for desc in cur.description]
    bookings_dict = [ dict(zip(colnames,booking)) for booking in bookings ]
    pprint(bookings)

    # Get all the past bookings here
    sql = '''select bk.booking_id, bk.attraction_id, att.name attraction_spot, att.description, att.address, att.price_per_ticket, bk.number_of_tickets,
                   bk.date_of_booking, bk.status from booking bk
                   inner join "user" usr
                   on bk.user_id = usr.user_id
                   inner join attraction att
                   on bk.attraction_id = att.attraction_id 
                   where bk.date_of_booking < current_date and bk.user_id = \'{}\' '''.format(current_user.get_id())
    pprint(sql)
    cur.execute(sql)
    past_bookings = cur.fetchall()

    colnames = [desc[0] for desc in cur.description]
    past_bookings_dict = [dict(zip(colnames, booking)) for booking in past_bookings]

    # Get user's info here
    sql = '''select name, email, contact from "user" where user_id = \'{}\' '''.format(current_user.get_id())
    pprint(sql)
    cur.execute(sql)
    user_details = cur.fetchall()

    colnames = [desc[0] for desc in cur.description]
    user_details_dict = [dict(zip(colnames, user)) for user in user_details]

    cur.close()
    conn.close()
    return render_template('viewBooking.html', bookings=bookings_dict, past_bookings=past_bookings_dict, today_date=datetime.date.today(), user_details=user_details_dict)

@app.route('/cancelBooking/<booking_id>/<attraction_id>/<number_of_tickets>/<date>')
def cancelBooking(booking_id=None, attraction_id=None, number_of_tickets=None, date=None):

    pprint(booking_id)
    pprint(attraction_id)
    pprint(number_of_tickets)
    pprint(date)

    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('delete from booking where booking_id = \'{}\';'.format(booking_id))
    sql_update = ''' update day_attraction set number_of_tickets_booked = number_of_tickets_booked - {} where
                    attraction_id = \'{}\' and date =  \'{}\' '''.format(number_of_tickets, attraction_id, date)
    cur.execute(sql_update)
    conn.commit()
    cur.close()
    conn.close()

    flash('Booking successfully cancelled')
    return redirect(url_for('viewBookings'))


@app.route('/')
@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        cur = get_db_connection().cursor()
        cur.execute('SELECT * FROM "user" WHERE email=\'{}\' and password=\'{}\';'.format(request.form['email'], request.form['password']))
        user = cur.fetchone()
        cur.close()
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