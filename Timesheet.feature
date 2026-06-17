Feature: Time Tracking Management

Background:
Given the user is logged in

# ----------------------------------

# Timer Tracking

# ----------------------------------

Scenario: Start timer successfully with project and task
Given the Start Timer modal is open
And projects and tasks are available
And a project is selected
And a task is selected
And a valid description is entered
When the user clicks "Start Timer"
Then a success message is displayed
And the modal closes
And the timer is updated in the global state
And the UI shows the running timer

Scenario: Start timer successfully with project only
Given the Start Timer modal is open
And a project is selected
And no task is selected
And a valid description is entered
When the user clicks "Start Timer"
Then a success message is displayed
And the timer is updated in the global state
And the UI shows the running timer

Scenario: Prevent timer start without project
Given the Start Timer modal is open
And no project is selected
And a valid description is entered
When the user clicks "Start Timer"
Then an error message "Please select a project" is displayed
And the timer is not started

Scenario: Prevent timer start with empty description
Given the Start Timer modal is open
And a project is selected
And the description field is empty
When the user clicks "Start Timer"
Then an error message "Task description is required" is displayed
And the timer is not started

Scenario: Start a new timer while another timer is active
Given an active timer is currently running
And the Start Timer modal is open
And a project is selected
And a valid description is entered
When the user clicks "Start Timer"
Then the previous timer is stopped
And the new timer starts successfully
And the UI reflects the new running timer

Scenario: Derive work mode from presence status
Given the user's presence status is "WFO"
And the Start Timer modal is open
And a project is selected
And a valid description is entered
When the user clicks "Start Timer"
Then the timer is created with work mode "WFO"

Scenario: Stop running timer successfully
Given a timer is currently running
When the user clicks "Stop Timer"
Then the timer is stopped
And the timer is removed from the global state
And the UI displays no active timer

Scenario: Prevent stopping timer when none is active
Given no timer is currently running
When the user attempts to stop a timer
Then no timer is stopped
And an appropriate message is displayed

Scenario: Display active timer on page load
Given an active timer exists
When the user opens the Timesheet page
Then the active timer details are displayed

Scenario: Display no timer when none is active
Given no active timer exists
When the user opens the Timesheet page
Then "No active timer" is displayed

Scenario: Update elapsed time in real time
Given a timer is running
When the user views the tracker
Then the elapsed time updates every second

# ----------------------------------

# Timer UI

# ----------------------------------

Scenario: Display Start Timer modal fields
When the user opens the Start Timer modal
Then the Project field is visible
And the Task field is visible
And the Task Description field is visible
And the Billable checkbox is visible
And the Work Mode field is visible and disabled
And the Cancel button is visible
And the Start Timer button is visible

Scenario: Display loading indicators in Start Timer modal
Given the Start Timer modal is open
When projects are loading
Then the Project field displays a loading indicator

```
When tasks are loading
Then the Task field displays a loading indicator

When the user starts a timer
Then the Start Timer button displays a loading spinner
```

# ----------------------------------

# Manual Time Entries

# ----------------------------------

Scenario: Create manual time entry successfully
Given the Log Time Manually modal is open
And a project is selected
And a task is selected
And a valid date is selected
And a valid start time is entered
And a valid end time is entered
And a valid description is entered
When the user clicks "Save Entry"
Then the time entry is created successfully
And a success message is displayed

Scenario: Prevent manual entry without project
Given the Log Time Manually modal is open
And all required fields except project are completed
When the user clicks "Save Entry"
Then an error message "Please fill in all required fields" is displayed
And the entry is not created

Scenario: Prevent manual entry without task
Given the Log Time Manually modal is open
And all required fields except task are completed
When the user clicks "Save Entry"
Then an error message "Please fill in all required fields" is displayed
And the entry is not created

Scenario: Prevent manual entry with empty description
Given the Log Time Manually modal is open
And all required fields except description are completed
When the user clicks "Save Entry"
Then an error message "Task description is required" is displayed
And the entry is not created

Scenario: Prevent manual entry with end time before start time
Given the Log Time Manually modal is open
And a valid project and task are selected
And the start time is later than the end time
When the user clicks "Save Entry"
Then an error message is displayed
And the entry is not created

Scenario: Prevent overlapping manual time entries
Given an existing time entry exists from 09:00 to 12:00
And the Log Time Manually modal is open
And the user enters a new time entry from 10:00 to 13:00
When the user clicks "Save Entry"
Then an overlap validation error is displayed
And the entry is not created

Scenario: Update existing time entry by increasing hours
Given an existing time entry exists from 09:00 to 13:00
When the user changes the duration from 4 hours to 6 hours
And the field loses focus
Then the time entry is updated successfully
And totals are recalculated

Scenario: Update existing time entry by decreasing hours
Given an existing time entry exists from 09:00 to 15:00
When the user changes the duration from 6 hours to 3 hours
And the field loses focus
Then the time entry is updated successfully
And totals are recalculated

# ----------------------------------

# Manual Entry UI

# ----------------------------------

Scenario: Display Log Time Manually modal fields
When the user opens the Log Time Manually modal
Then the Project field is displayed
And the Task field is displayed
And the Date field is displayed
And the Start Time field is displayed
And the End Time field is displayed
And the Description field is displayed
And the Save Entry button is displayed

Scenario: Pre-populate fields from selected time slot
Given the user selects a time slot at 10:00 on 2026-02-06
When the Log Time Manually modal opens
Then the Date field contains "2026-02-06"
And the Start Time field contains "10:00"
And the End Time field contains "11:00"
