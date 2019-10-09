
## PM2

Doesn't always update environment variables.
Fix: `pm2 delete project-bog && pm2 start ~/ecosystem.json`

## Nginx configs

/etc/nginx/sites-available/bog-api

to restart:

sudo /etc/init.d/nginx reload

ecosystem and env config:

~/ecosystem.json

to update env variables, you for some reason have to pm2 kill [process]
and then pm2 start ~/ecosystem.json

## SSL

SSL Certificate using Let's Encrypt

Vaguely followed this guide:
https://www.smalldata.tech/blog/2015/12/29/nginx-nodejs-and-https-via-letsencrypt
