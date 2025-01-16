# Minimal Python Flask Dockerized Application run on Gunicorn #

Build the image using the following command

```bash
$ docker build -t ubi-flask:latest .
```

Run the Docker container using the command shown below.

```bash
$ docker run --rm -it -p 5000:5000 -e GUN_WORKERS=8 -e GUN_THREADS=2 ubi-flask:latest
```
Note: Number of worker processes (2 x $num_cores) + 1

The application will be accessible at http:127.0.0.1:5000 or if you are using boot2docker then first find ip address using `$ boot2docker ip` and the use the ip `http://<host_ip>:5000`
