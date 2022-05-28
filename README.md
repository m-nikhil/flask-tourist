# requierement
- postgres database
- python 3.9 version

# install pipenv global
- pip3 install -U pipenv

# dependency install
- pipenv shell (Incase of py version conflit, python3.9 -m pipenv shell)
- pipenv install

# setup database
- rename sample.env to .env
- change the database details in .env
- pipenv shell
- python3 init_db.py

# run
- pipenv shell
- python3 app.py
- open brower and navigate to http://localhost:5000

# install dependencies
- pipenv install <package> (outside of pipenv shell)
