from sqlalchemy.engine.url import URL

SQLALCHEMY_DATABASE_URI = str(URL('postgres',
                                  username='take_home',
                                  password='take_home',
                                  host='postgres',
                                  database='take_home',
                                  port=5432))
