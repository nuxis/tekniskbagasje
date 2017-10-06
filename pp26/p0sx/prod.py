from p0sx.settings.base import *

ALLOWED_HOSTS = ['p0sx.pp26.polarparty.no']

SECRET_KEY = ''

DEBUG = False

DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': 'p0sx_pp26',
    'USER': 'p0sx_pp26',
    'PASSWORD': '',
    'HOST': 'postgres',
    'PORT': '5432',
  }
}

MEDIA_URL = 'https://p0sx.pp26.polarparty.no/media/'
