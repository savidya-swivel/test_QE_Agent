Feature: Time Tracking Management

Background:
Given the user is logged in


Scenario: Prevent timer start when project is inactive or deleted

Given the user is logged in
And the Start Timer modal is open
And a project was selected previously
And the project has been deleted or marked inactive by an administrator
When the user clicks "Start Timer"
Then an error message is displayed indicating the project is no longer available
And the timer is not started

Scenario: Handle network interruption while starting a timer

Given the user is logged in
And the Start Timer modal is open
And a valid project is selected
And a valid description is entered
When the user clicks "Start Timer"
And the network connection is lost before the API response is received
Then an error message is displayed
And no timer is shown as running
And the Start Timer button becomes enabled again

Feature: Flower bloom Management

Scenario: Handle flower bloom

Given the user is logged in
And the flower modal is open
When the user clicks "flowers"
Then flower is appearing
And the flower will bloom