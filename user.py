from flask import request
from flask_login import UserMixin
from database import get_db_connection

class User(UserMixin):

    def __init__(self,id,name,email,password):
        self.id = id
        self.name = name
        self.password=password
        self.email=email

    @staticmethod
    def get(user_id):
        cur = get_db_connection().cursor()
        cur.execute('SELECT * FROM "user" WHERE user_id = {};'.format(user_id))
        user=cur.fetchone()
        if not user:
            return None
        return User(user[0],user[1],user[2],user[3])

    def get_id(self):
        return self.id
