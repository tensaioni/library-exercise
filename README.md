# README

To run the app, just use
```sh
docker compose up
```

App will be available by default at http://localhost:3000

# DESIGN DECISIONS
- Lease due date is calculated from the creation date of the record (we'll get back to it later)
- both library card number and book serial number only care about being 6 digits, so they don't care about leading zeros
- spam of "your book is due today" after being overdue is on purpose, just to annoy people being late
- recurring tasks setup through Solid Queue, but Sold Queue is not really set up for production

# FURTHER IMPROVEMENTS
- general small refactoring (code duplication)
- make emails case insensitive, currently case sensitive
- not allow books to be completely deleted, implement a typical soft delete to keep it lease information
- authentication/authorization
- more robust reminders, if for whatever reason a reminder for the specific day can't be sent, it maybe should've been sent another day with more customized message?
- better book lease lifecycle, saving a due_date during lease creation, doing some actions where book is overdue etc.
- pagination in controllers (wasn't necessary due to small scale)
