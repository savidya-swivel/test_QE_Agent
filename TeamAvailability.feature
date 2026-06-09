Feature: Team Availability Management

  Background:
    Given the user is authenticated
    And the user navigates to the Team Availability page

  # ----------------------------------
  # Activity Feed
  # ----------------------------------

  Scenario: View Activity Feed tab
    Then the "Activity Feed" tab is visible

  Scenario: Open Activity Feed
    When the user clicks the "Activity Feed" tab
    Then the activity feed section is displayed

  Scenario: Display loading indicator while fetching activities
    When the user selects a date range
    Then a loading indicator is displayed while activity data is loading

  Scenario: Display no activity message
    Given no activity exists for the selected date range
    When the user views the Activity Feed
    Then the message "No activity found for the selected date range" is displayed

  Scenario: Display activity feed item details
    Given activity data exists
    When the user views an activity item
    Then the item displays avatar, user name, timestamp, event type and work location

  Scenario: Display status indicator color based on event type
    Given activity data exists
    When the user views an activity item
    Then the status indicator color matches the event type

  Scenario: Display activities in chronological order
    Given multiple activity records exist
    When the user views the Activity Feed
    Then activities are displayed in chronological order

  Scenario: Display activity feed layout correctly
    Then all activity feed elements are aligned and displayed correctly

  Scenario: Display responsive activity feed layout
    When the screen size changes
    Then the activity feed layout adapts without breaking

  Scenario: Populate activity feed with data
    Given activity records exist for the selected date range
    Then the correct activity data is displayed

  Scenario: Handle large activity volumes
    Given a large amount of activity data exists
    When the user views the Activity Feed
    Then the page remains responsive
    And the feed remains scrollable

  Scenario: Display default avatar when profile image is missing
    Given a user has no profile image
    When the user's activity appears in the feed
    Then a default avatar with initials is displayed

  Scenario: Handle missing work location
    Given a user activity has no work location
    When the activity is displayed
    Then the work location section is hidden

  Scenario: Handle long user names
    Given a user has a long display name
    When the activity is displayed
    Then the name is truncated without breaking the layout

  Scenario: Handle activity feed API failure
    Given the activity API request fails
    When the user opens the Activity Feed
    Then a no activity or error message is displayed

  Scenario: Prevent invalid date range selection
    When the user attempts to select an invalid date range
    Then the invalid range is prevented or handled gracefully

  # ----------------------------------
  # WFH / WFO Status
  # ----------------------------------

  Scenario: Display WFH status
    Given a user signed in as WFH
    When viewing Team Availability
    Then a WFH indicator is displayed

  Scenario: Display WFO status
    Given a user signed in as WFO
    When viewing Team Availability
    Then a WFO indicator is displayed

  Scenario: Hide WFH/WFO indicator for non-signin events
    Given an event is not a sign-in event
    And no work location exists
    Then no WFH or WFO indicator is displayed

  Scenario: Admin views all WFH/WFO statuses
    Given the user is an administrator
    When viewing Team Availability
    Then WFH and WFO statuses are visible for all users

  Scenario: Non-admin views teammate WFH/WFO statuses
    Given the user is a non-admin
    When viewing Team Availability
    Then WFH and WFO statuses are visible for teammates

  # ----------------------------------
  # Manual Time Updates
  # ----------------------------------

  Scenario: Edit own previous sign-in or sign-out time
    Given the user has a previous day sign-in or sign-out event
    When the user edits and saves the time
    Then the event time is updated
    And a manually edited indicator is displayed

  Scenario: Prevent editing another user's event
    Given another user's event exists
    Then the edit option is not displayed

  Scenario: Display manually edited indicator
    Given an event was manually edited
    Then a manually edited icon is displayed

  Scenario: Allow only time updates
    Given the user is editing an event
    When the user attempts to change the date
    Then the change is rejected

  # ----------------------------------
  # Manager Approval
  # ----------------------------------

  Scenario: Hide pending manual entries
    Given a manual entry is pending approval
    When viewing Team Availability
    Then the entry is not displayed

  Scenario: Display approved manual entries
    Given a manual entry is approved
    When viewing Team Availability
    Then the entry is displayed
    And a manually edited icon is shown

  Scenario: Hide rejected manual entries
    Given a manual entry is rejected
    When viewing Team Availability
    Then the entry is not displayed

  # ----------------------------------
  # Dashboard Card
  # ----------------------------------

  Scenario: Open Team Availability page from dashboard card
    Given the Team Availability card is visible
    When the user clicks "View All"
    Then the Team Availability page opens
    And the user's team is preselected

  Scenario: Display Team Availability card for users with teams
    Given the user belongs to a team
    Then the Team Availability card is displayed

  Scenario: Hide Team Availability card for users without teams
    Given the user does not belong to any team
    Then the Team Availability card is not displayed

  Scenario: Display team member information on dashboard card
    Given the Team Availability card is displayed
    Then team member names, avatars and statuses are shown

  Scenario: Refresh dashboard card manually
    Given team member status changes
    When the user clicks refresh
    Then the dashboard card data updates

  Scenario: Auto-refresh dashboard card
    Given team member status changes
    When five minutes pass
    Then the dashboard card data refreshes automatically

  # ----------------------------------
  # Multi-Team Availability
  # ----------------------------------

  Scenario: Display team picker for multi-team users
    Given the user belongs to multiple teams
    Then the team picker is visible

  Scenario: Hide team picker for single-team users
    Given the user belongs to one team
    Then the team picker is hidden

  Scenario: Switch teams using team picker
    Given the team picker is visible
    When the user selects another team
    Then the dashboard card updates with that team's data

  # ----------------------------------
  # Team Availability Page UI
  # ----------------------------------

  Scenario: Display Activity Feed and Detailed View tabs
    Then the "Activity Feed" and "Detailed View" tabs are visible

  Scenario: Display filters in Detailed View
    Given the user is on the Detailed View tab
    Then date range, team and name filters are displayed

  Scenario: Display Team Members card
    Given today's date is selected
    And a team filter is applied
    Then the Team Members card is displayed

  # ----------------------------------
  # Functional Features
  # ----------------------------------

  Scenario: Open Add Missing Record modal
    Given the user is on Detailed View
    When the user clicks "Add Missing Record"
    Then the Add Missing Record modal is displayed

  Scenario: Export presence report
    Given a valid date range is selected
    When the user clicks "Export Report"
    Then a presence report file is downloaded

  Scenario: Display export loading state
    Given a valid date range is selected
    When the user clicks "Export Report"
    Then an exporting indicator is displayed until export completes