Feature: Announcement Management

Background:
Given the user is logged in

# ----------------------------------

# Admin Announcement Management

# ----------------------------------

Scenario: Admin creates a standard info announcement for everyone
Given the user is logged in as an Admin
And the Announcement Management page is open
When the user enters a title and message
And selects announcement type "Info"
And sets the show date to today
And sets the end date to next week
And selects audience "All Employees"
And clicks "Save"
Then the announcement is successfully created
And a success notification is displayed
And the announcement appears in the admin list

Scenario: Admin creates a shoutout targeting a specific employee
Given the user is logged in as an Admin
And the Create Announcement modal is open
When the user selects announcement type "Shoutout"
And selects target type "User"
And chooses a specific employee
And enters a title and message
And clicks "Save"
Then the announcement is created successfully
And the linked user ID is stored
And the user's avatar and name are displayed

Scenario: Admin creates a shoutout targeting a team
Given the user is logged in as an Admin
And the Create Announcement modal is open
When the user selects announcement type "Shoutout"
And selects target type "Team"
And chooses the "Engineering" team
And enters a title and message
And clicks "Save"
Then the announcement is created successfully
And the team reference is stored
And the team name is displayed on the announcement card

Scenario: Admin adds an external link to an announcement
Given the user is logged in as an Admin
When the user enters a valid URL in the Link field
And completes all required announcement details
And clicks "Save"
Then the announcement is created successfully
And a Read More link is displayed on the dashboard card

Scenario: Admin edits an existing announcement
Given the user is logged in as an Admin
And an existing announcement is selected
When the user updates the title, message, or audience
And clicks "Update"
Then the announcement is updated successfully
And users see the updated content after refresh

Scenario: Admin deletes an announcement with comments
Given an announcement exists with comments
And the user is logged in as an Admin
When the user deletes the announcement
Then the announcement is removed
And all associated comments are deleted

Scenario: Admin hides an announcement without deleting it
Given an active announcement exists
When the Admin sets Active to false
And saves the changes
Then the announcement is hidden from all dashboards
But the announcement remains visible in the admin list

# ----------------------------------

# Announcement Visibility Rules

# ----------------------------------

Scenario: Announcement is hidden before show date
Given an announcement exists with a show date of tomorrow
When a user views the dashboard today
Then the announcement is not displayed

Scenario: Announcement expires after end date
Given an announcement exists with an end date of yesterday
When a user views the dashboard today
Then the announcement is not displayed

Scenario: General announcement is visible to all users
Given an announcement exists for audience "All Employees"
When any authenticated user views the dashboard
Then the announcement is displayed

Scenario: Team-specific announcement visibility
Given an announcement exists for the "Engineering" team
When a Marketing team member views the dashboard
Then the announcement is not displayed
When an Engineering team member views the dashboard
Then the announcement is displayed

Scenario: User-specific announcement visibility
Given an announcement exists for user "[user1@example.com](mailto:user1@example.com)"
When "[user2@example.com](mailto:user2@example.com)" views the dashboard
Then the announcement is not displayed
When "[user1@example.com](mailto:user1@example.com)" views the dashboard
Then the announcement is displayed

# ----------------------------------

# Reactions

# ----------------------------------

Scenario: User adds and removes a Like reaction
Given an active announcement is visible
When the user clicks the Like button
Then the Like count increases by 1
And the Like button is highlighted

```
When the user clicks the Like button again
Then the Like count decreases by 1
And the highlight is removed
```

Scenario: User adds multiple reaction types
Given an announcement is visible
When the user clicks Love and Celebrate reactions
Then both reaction counts increase
And both reactions remain active

# ----------------------------------

# Comments

# ----------------------------------

Scenario: User posts a comment
Given an announcement is visible
When the user opens the comments section
And enters a comment
And clicks Post
Then the comment is added successfully
And the comments count increases by 1
And the comment displays the user's name and timestamp

Scenario: User deletes their own comment
Given the user has posted a comment
When the user deletes the comment
Then the comment is removed
And the comments count decreases by 1

Scenario: Admin moderates comments
Given a user has posted a comment
And the current user is an Admin
When the Admin deletes the comment
Then the comment is removed
And the comments count is updated

# ----------------------------------

# Dashboard Display

# ----------------------------------

Scenario: User navigates through multiple announcements
Given there are three active announcements
When the dashboard loads
Then the announcement carousel is displayed
And the user can navigate between announcements

Scenario: Announcement supports markdown formatting
Given an announcement contains markdown content
When the announcement is displayed
Then the markdown is rendered correctly
And raw markdown syntax is not displayed

Scenario: No active announcements available
Given there are no active announcements for the user
When the dashboard loads
Then the announcement carousel is hidden
And no empty space is displayed

# ----------------------------------

# Security & Validation

# ----------------------------------

Scenario: Non-admin user attempts to access announcement management
Given the user is logged in as a non-admin employee
When the user navigates to "/admin/announcements"
Then access is denied
And the user is redirected to the dashboard

Scenario: Prevent creation with invalid date range
Given the user is logged in as an Admin
When the end date is earlier than the show date
And the user clicks Save
Then the error message "End date must be after show date" is displayed
And the announcement is not created
