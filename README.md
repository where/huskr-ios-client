huskr-ios-client
================

iOS client for a sample client-server architected app.

Next steps for features:
------------------------

### Creating statuses

- Show the error from the server when creating a post. To force an error, try to post a status with more than 140 characters.
- Add client side validation for creating a status, so the user doesn't have to wait for a network request to know that the status isn't going to get created.
- Make the scrolling on create post automatic, as the user hits "return".
- The loading indicator when creating the status doesn't block user input. The user could hit the submit button multiple times.

### Fetching & displaying statuses

- Parse the "created date" from the JSON response, display it in StatusTableCell.
- Make the table cells have alternating backgrounds colors.