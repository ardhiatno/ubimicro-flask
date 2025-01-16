# gunicorn_config.py
wsgi_app = "app:app"
bind = "0.0.0.0:5000"
# Number of worker processes (2 x $num_cores) + 1
workers = {GUN_WORKERS}
threads = {GUN_THREADS}

# Worker class (default is sync)
worker_class = "{GUN_WORKER_CLASS}"

# Logging level
loglevel = "{GUN_LOGLEVEL}"