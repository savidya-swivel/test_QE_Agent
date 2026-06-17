Feature: OPD Medical Claim Management and Review

  Background:
    Given the user is logged in to the Swivel Portal

  # ==========================================
  # Employee Claim Submission
  # ==========================================

  Scenario: Successful OPD claim submission with valid details and receipt
    Given the employee has a positive OPD balance
    When the employee navigates to the "Submit OPD Claim" page
    And enters all required claim details with valid information
    And uploads a valid receipt
    And clicks the "Submit" button
    Then the claim should be submitted successfully
    And the employee's OPD balance should be updated correctly
    And a confirmation message should be displayed
    And the claim status should be "Pending Review"

  Scenario: OPD claim submission with insufficient balance
    Given the employee has an OPD balance of X
    When the employee submits an OPD claim for an amount greater than X
    And uploads a valid receipt
    And clicks the "Submit" button
    Then the system should prevent the claim submission
    And an error message indicating insufficient balance should be displayed

  Scenario: OPD claim submission with missing required fields
    When the employee navigates to the "Submit OPD Claim" page
    And leaves one or more required fields empty
    And clicks the "Submit" button
    Then the system should highlight the missing fields
    And the claim should not be submitted
    And an error message should prompt the employee to complete all required fields

  Scenario: OPD claim submission with an invalid receipt file type
    When the employee navigates to the "Submit OPD Claim" page
    And enters all required claim details with valid information
    And uploads a file with an unsupported extension
    And clicks the "Submit" button
    Then the system should prevent the file upload
    And an error message indicating an invalid file type should be displayed

  Scenario: Employee views current OPD balance
    Given the employee has an OPD balance
    When the employee navigates to the dashboard
    Then the current OPD balance should be displayed accurately
    And the displayed balance should reflect recent claim submissions or approvals

  Scenario: Employee submits an OPD claim exceeding the annual limit
    Given the employee has almost reached the annual OPD claim limit
    When the employee attempts to submit a new claim
    And the new claim amount exceeds the annual limit
    Then the system should display a warning about exceeding the annual limit
    And the claim submission should be blocked or flagged for special review

  # ==========================================
  # Admin Claim Management
  # ==========================================

  Scenario: Admin filters OPD claims by status
    Given there are OPD claims with various statuses
    When the admin navigates to the "OPD Claims" section
    And applies the "Pending" status filter
    Then only claims with status "Pending" should be displayed

  Scenario: Admin views detailed OPD claim information
    Given at least one OPD claim exists
    When the admin navigates to the "OPD Claims" section
    And selects a specific claim
    Then the detailed claim information should be displayed
    And employee details, claim amount, date, status, receipt, and comments should be visible

  Scenario: Admin approves a pending OPD claim
    Given a pending OPD claim exists
    When the admin navigates to the "Admin OPD Claims Review & Approval" section
    And selects the pending claim
    And clicks the "Approve" button
    And provides an optional comment
    Then the claim status should be updated to "Approved"
    And the employee should receive an approval notification
    And the approval comment should be recorded

  Scenario: Admin rejects a pending OPD claim
    Given a pending OPD claim exists
    When the admin navigates to the "Admin OPD Claims Review & Approval" section
    And selects the pending claim
    And clicks the "Reject" button
    And provides a rejection reason
    Then the claim status should be updated to "Rejected"
    And the employee should receive a rejection notification with the provided reason
    And the rejection reason should be recorded

  Scenario: Admin views OPD claims dashboard
    When the admin navigates to the "OPD Claims" section
    Then a list of all OPD claims should be displayed
    And claims should be filterable by status
    And claims should be sortable by date, employee name, and amount
    And each claim should display employee name, claim date, amount, and current status
    And the admin should be able to open a claim and view its full details

  Scenario: Admin changes claim status to "Under Review"
    Given an employee has submitted a claim with status "Pending Review"
    When the admin selects the claim
    And changes the status to "Under Review"
    Then the claim status should be updated to "Under Review"
    And the employee should see the updated status in "My Claims"

  Scenario: Admin changes claim status to "Cash Pass"
    Given an OPD claim has completed the review process
    When the admin selects the claim
    And changes the status to "Cash Pass"
    Then the claim status should be updated to "Cash Pass"
    And the employee should see the updated status in "My Claims"
    And the employee should be informed that payment processing is underway

  # ==========================================
  # File Upload Validation
  # ==========================================

  Scenario: User selects a file larger than 5 MB
    When the employee navigates to the OPD claim submission page
    And uploads a file larger than 5 MB
    Then a warning message should be displayed immediately
    And the message should state "Total file size exceeds 5 MB. Please select files within the combined limit."

  Scenario: User replaces an oversized file with a valid file
    Given a file larger than 5 MB has been selected
    When the employee replaces it with a valid PNG or PDF file within the size limit
    Then the warning message should disappear
    And the Submit button should become enabled

  Scenario: User uploads a valid file within the size limit
    When the employee uploads a valid PNG or PDF file of 5 MB or less
    And completes all required claim details
    And clicks the "Submit" button
    Then the claim form should be submitted successfully