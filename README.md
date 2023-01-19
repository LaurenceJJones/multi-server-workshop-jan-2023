## Multi Server Workshop January 2023

Hey welcome to the repository holding the configurations and files needed for the multi-server workshop.

### NGINX

Holds all nginx configuration for my domain ljcybersolutions.uk - obviously dont deploy with these config values. I highly encourage you to head over to [nginxconfig.io](https://nginxconfig.io) and use their nginx config builder.

### Crowdsec

Crowdsec folder contains the modifications we will do to prepare crowdsec for a multi-server installation

These are:
- Use postgresql instead of sqlite
- Modify the flush parameters to store a greater history
- Set `api.server.use_forwarded_for_headers` to true
