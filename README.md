## __Online-doctor__
Expert system, which simulates online consultation with doctor.

### __System architecture__

Project is split into three components:
- prolog server
- python server
- client application


Client application is simple React application, which runs on `localhost:3000`. <br>
Prolog server side contains knowledge database `db.pl` and server `api.pl` which creates HTTP server on `localhost:8080`. <br>
Python server contains database in `Network2.xdsl` file, genereated using _GeNIe Modeler_. `api.py` which is entry point, creates a HTTP server on `localhost:5000`.


There are currently defined two API endpoints:
- `GET` `/api/symptons` - used to get list of all possible symptoms from database
- `POST` `api/diagnose` - used to make a diagnosis

### __How to run__

```
docker-compose up --build
```
Then open `http://localhost:3000/` in your web browser.

> Keep in mind that server side files are copied into container during the build, because of that after any changes applied to the prolog and python containers must be recreated. Using local interpreters for debugging is recommended.

#### __Python server setup__
> This part is required to run a python server

Python server use package called _pysmile_, which is wrapper on engine _SMILE Engine_ created by https://www.bayesfusion.com/. Academic users can download our software without cost for academic teaching and research.

Please register on this site and download `pysmile.so` and `pysmile_license.py`.<br>
Next, put both of them in `python-server` directory.
