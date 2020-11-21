## __Online-doctor__
Expert system, which simulates online consultation with doctor.

### __System architecture__

Project is split into two components:
- prolog server
- client application

Client application is simple React application, which runs on `localhost:3000`. <br>
Server side contains knowledge database _db.pl_ and server _api.pl_ which creates HTTP server on `localhost:8080`.

There are currently defined two API endpoints:
- `/api/symptons` - used to get list of all possible symptoms from database
- `api/diagnose` - used to make a diagnosis

> TODO endpoints documentations

### __Run__

```
docker-compose up --build
```
> Keep in mind that server side files are copied into container during the build, because of that after any changes applied to the prolog code container must be recreated. Using local prolog interpreter for debugging is recommended.
