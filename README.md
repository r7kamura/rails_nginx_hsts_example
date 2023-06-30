# rails_nginx_hsts_example

This is an example application to test the behavior of HSTS when combined with Rails and Nginx.

## About

### Nginx side

On the Nginx server side, the `Strict-Transport-Security` header is added by the following configuration:

```nginx
add_header Strict-Transport-Security "max-age=31536000;";
```

### Rails side

On the Rails application side, the `Strict-Transport-Security` header is added by the following configuration:

```ruby
config.force_ssl = true
```

### Result

As a result, when you send an HTTPS request, you will get a response with double `Strict-Transport-Security` header, as shown below:

```
$ curl --head --header "X-Forwarded-Proto: https" http://localhost:80
HTTP/1.1 200 OK
Server: nginx/1.25.1
Date: Fri, 30 Jun 2023 07:49:18 GMT
Content-Type: text/html; charset=utf-8
Connection: keep-alive
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 0
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Vary: Accept
ETag: W/"bba8b0d63cfb920be0370770c97ac0c1"
Cache-Control: max-age=0, private, must-revalidate
Content-Security-Policy: script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'
X-Request-Id: d7438086-921d-4b40-aeaf-eddddd3e7a46
X-Runtime: 0.002977
Server-Timing: start_processing.action_controller;dur=0.08, render_template.action_view;dur=0.13, process_action.action_controller;dur=0.78
Strict-Transport-Security: max-age=63072000; includeSubDomains
Strict-Transport-Security: max-age=31536000;
```

## Usage

### Prerequisites

- Docker

### Setup

After git clone, run the following command to set up:

```
docker compose run --rm rails bin/setup
```

### Run server

After set up, start nginx and rails server with the following command:

```
docker compose up
```

This will allow you to access the nginx server at http://localhost:80.
