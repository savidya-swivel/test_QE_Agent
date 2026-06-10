Feature: User Authentication

  As a user
  I want to log in or sign up
  So that I can access the application

  Scenario: Successful Login with valid credentials
  Given the user is on the Login page
  When the user enters a valid email address
  And the user enters a valid password
  And clicks the "Login" button
  Then a success message should be displayed
  And the login form should be cleared

  Scenario: Login with empty fields
  Given the user is on the Login page
  When the user clicks the "Login" button without entering any data
  Then the form should prevent submission
  And validation messages should be displayed for required fields

  Scenario: Switch from Login to Signup page
  Given the user is on the Login page
  When the user clicks the "Sign Up" link
  Then the Signup form should be displayed
  And the Name field should be visible

  Scenario: Successful Signup with valid details
  Given the user is on the Signup page
  When the user enters a valid name
  And the user enters a valid email address
  And the user enters a valid password
  And clicks the "Sign Up" button
  Then a success message should be displayed
  And the signup form should be cleared

  Scenario: Signup without entering a name
  Given the user is on the Signup page
  When the user leaves the Name field empty
  And enters a valid email address
  And enters a valid password
  And clicks the "Sign Up" button
  Then the form should prevent submission
  And a validation message should be displayed for the Name field

  Scenario: Signup with an invalid email address
  Given the user is on the Signup page
  When the user enters a name
  And enters "invalid-email" in the Email field
  And enters a password
  And clicks the "Sign Up" button
  Then the form should prevent submission
  And a validation message should be displayed for the Email field

  Scenario: Switch from Signup to Login page
  Given the user is on the Signup page
  When the user clicks the "Login" link
  Then the Login form should be displayed
  And the Name field should not be visible

  Scenario: Verify password masking
  Given the user is on the Login page
  When the user enters a password
  Then the password characters should be masked

  Scenario: Verify fields are cleared after successful signup
  Given the user is on the Signup page
  When the user successfully submits the form
  Then the Name field should be empty
  And the Email field should be empty
  And the Password field should be empty

  Scenario: Enter extremely long values in form fields
  Given the user is on the Signup page
  When the user enters 500 characters in the Name field
  And enters a valid email address
  And enters 500 characters in the Password field
  And clicks the "Sign Up" button
  Then the application should remain responsive
  And no UI breakage should occur

