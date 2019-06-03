# Angry Unicorn!

Run your own Angry Unicorn if GitHub is down!

Environment variables to customize the page:

- `TOP_MSG` (defaults to "This page is taking way too long to load.")
- `BOTTOM_MSG` (defaults to "Sorry about that. Please try refreshing and contact us if the problem persists.")
- `LISTEN_PORT` tcp port on which the service is listening (defaults to `8080`)

Run the image:

```bash
$ docker run -d -p 8080:8080 \
  -e TOP_MSG="My other page is a 500" \
  -e BOTTOM_MSG='But it does not have Unicornzzzzzz!!!' \
  thajeztah/angry-unicorn:latest 
```

And visit http://localhost:8080 in your browser.

