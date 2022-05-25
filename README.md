# install pipenv global
- pip3 install -U pipenv

# run
- pipenv install
- pipenv shell (Incase of py version conflit, python3 -m pipenv shell)
- python3 app.py
- exit (to exit shell)

# setup database
- pipenv shell
- python3 init_db.py

# install
- pipenv install <package> (outside of pipenv shell)
