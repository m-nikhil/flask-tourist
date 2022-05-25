import os
import psycopg2
from dotenv import load_dotenv

load_dotenv(override=True)
conn = psycopg2.connect(host= os.getenv('DB_HOST'),
                        database=os.getenv('DB_DATABASE'),
                        user=os.getenv('DB_USERNAME'),
                        password=os.getenv('DB_PASSWORD'),
                        port=os.getenv('DB_PORT'))

cur = conn.cursor()
cur.execute(open("schema.sql", "r").read())
conn.commit()

cur.close()
conn.close()