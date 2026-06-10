Feature: Position Management and Profile Synchronization

Background:
Given a clinic named "test_position_clinic" exists
And an Admin account exists with email "[ygvi1@virgilian.com](mailto:ygvi1@virgilian.com)"
And a User account exists with email "[oty6y@virgilian.com](mailto:oty6y@virgilian.com)"

# ----------------------------------

# Admin Position Management

# ----------------------------------

Scenario: Verify position field visibility for Admin account
Given the Admin user is on the signup page
Then the Position field is not displayed

```
When the Admin user logs in
And navigates to the Profile page
Then the Position field is displayed
```

Scenario: Super Admin updates Admin position
Given the Super Admin is logged in
And the Admin user exists in User Management
When the Super Admin updates the Admin's position
And saves the changes
Then the updated position is displayed in the User Management table
And the updated position is displayed in the Admin's Profile page

Scenario: Admin updates own position
Given the Admin user is logged in
And the Profile page is open
When the Admin updates their position
And saves the changes
Then the updated position is displayed in the Admin Profile page
And the updated position is displayed in the Super Admin User Management table

Scenario: Admin updates profile details from Profile page
Given the Admin user is logged in
And the Profile page is open
When the Admin updates profile information
And saves the changes
Then the updated information is displayed in the Profile page
And the updated information is displayed in the Super Admin User Management table

Scenario: Super Admin updates Admin profile details from User Management
Given the Super Admin is logged in
And the Admin user exists in User Management
When the Super Admin updates the Admin's profile information
And saves the changes
Then the updated information is displayed in the User Management table
And the updated information is displayed in the Admin Profile page

# ----------------------------------

# User Position Management

# ----------------------------------

Scenario: Verify position field visibility for User account
Given the User is on the signup page
Then the Position field is not displayed

```
When the User logs in
And navigates to the Profile page
Then the Position field is displayed
```

Scenario: Super Admin updates User position
Given the Super Admin is logged in
And the User exists in User Management
When the Super Admin updates the User's position
And saves the changes
Then the updated position is displayed in the User Management table
And the updated position is displayed in the User Profile page

Scenario: User updates own position
Given the User is logged in
And the Profile page is open
When the User updates their position
And saves the changes
Then the updated position is displayed in the User Profile page
And the updated position is displayed in the Super Admin User Management table

Scenario: User updates profile details from Profile page
Given the User is logged in
And the Profile page is open
When the User updates profile information
And saves the changes
Then the updated information is displayed in the Profile page
And the updated information is displayed in the Super Admin User Management table

Scenario: Super Admin updates User profile details from User Management
Given the Super Admin is logged in
And the User exists in User Management
When the Super Admin updates the User's profile information
And saves the changes
Then the updated information is displayed in the User Management table
And the updated information is displayed in the User Profile page

# ----------------------------------

# Super Admin Position Management

# ----------------------------------

Scenario: Super Admin updates own position
Given the Super Admin is logged in
And the Profile page is open
When the Super Admin updates their position
And saves the changes
Then the updated position is displayed in the Super Admin Profile page
And the updated position is displayed in the User Management table

Scenario: Super Admin updates profile details
Given the Super Admin is logged in
And the Profile page is open
When the Super Admin updates profile information
And saves the changes
Then the updated information is displayed in the Profile page
And the updated information is displayed in the User Management table

Scenario: Super Admin profile updates remain synchronized
Given the Super Admin profile information is displayed in User Management
When the Super Admin updates any editable profile field
Then the same values are reflected in the Profile page
And the same values are reflected in the User Management table
