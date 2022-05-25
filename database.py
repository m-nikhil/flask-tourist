import os
import psycopg2

def get_db_connection():
    conn = psycopg2.connect(host= os.getenv('DB_HOST'),
                            database=os.getenv('DB_DATABASE'),
                            user=os.getenv('DB_USERNAME'),
                            password=os.getenv('DB_PASSWORD'),
                            port=os.getenv('DB_PORT'))
    return conn