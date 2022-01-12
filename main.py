import datetime
import logging
import datetime as dt
import sys
from configparser import ConfigParser

for handler in logging.root.handlers:
    logging.root.removeHandler(handler)
config = ConfigParser()
config.read("config.conf")
LOG_LEVEL = config["logging"]["level"]
LOG_FILE_NAME_PREFIX = config["logging"]["logfile_name_prefix"]
LOG_FILE_NAME_EXT = config["logging"]["logfile_name_ext"]

print(LOG_LEVEL)
print(LOG_FILE_NAME_PREFIX)
print(LOG_FILE_NAME_EXT)
today = dt.datetime.today()
day = f'{today.year:02d}-{today.month:02d}-{today.day:02d}'
filename = f'{LOG_FILE_NAME_PREFIX}-{day}.{LOG_FILE_NAME_EXT}'
print(filename)
logging.basicConfig(level=LOG_LEVEL)
logger = logging.getLogger("-admin facade-")

logging.info('info message')

def print_to_log(level, msg):
    logger.log(level, f'{datetime.datetime.now()} {logging.getLevelName(level)} {msg}')

file_handler = logging.FileHandler(filename)
file_handler.setLevel(logging.DEBUG)
logger.addHandler(file_handler)

print_to_log(logging.INFO, 'starting facade ....')
try:
    print_to_log(logging.DEBUG, 'input x about to happen')
    x = int(input('number: '))
    print_to_log(logging.DEBUG, 'input x was success')
    print_to_log(logging.DEBUG, f'x is {x}')
except ValueError:
    #print('invalid')
    print_to_log(logging.CRITICAL, "wrong input for int")

def repo_add_ticket(obj_ticket):
    print_to_log(logging.DEBUG, f'adding ticket : {obj_ticket}')
    try:
        pass
    except BaseException as e:
        print_to_log(logging.ERROR, 'FAILED QUERY: INSERT INTO TICKETS ...')
        print_to_log(logging.ERROR, f'error during adding ticket : {obj_ticket},'\
                         f'error: {e}')