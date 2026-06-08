Feature: User Authentication

  Scenario: Successful login with valid credentials
    Given a valid user account exists
    And the API website is accessible
    When the user navigates to the login page
    And enters a valid username
    And enters a valid password
    And clicks the Login button
    Then the user should be successfully logged in
    And the dashboard should load successfully
    And connected OneDrive folders should be accessible

  Scenario: Login failure with invalid credentials
    Given the API website is accessible
    When the user navigates to the login page
    And enters an invalid username or password
    And clicks the Login button
    Then the login should fail
    And an appropriate error message should be displayed
    And the user should remain on the login page

Feature: Client Folder Management

  Scenario: All client folders from connected OneDrive are displayed
    Given the user is logged in
    And OneDrive is connected
    And client folders are available in OneDrive
    When the user navigates to the folder selection page
    Then all client folders should be displayed correctly
    And folder names should match the OneDrive structure

  Scenario: Clients page loads with all client cards
    Given the user is logged in
    And OneDrive is connected
    And client folders are available
    When the user navigates to the Clients page
    Then the Clients page should load without errors
    And all client cards should be displayed
    And each card should show the client name, initials, and a Generate Report button

  Scenario: Client names match OneDrive folder names
    Given the Clients page has loaded successfully
    When the user views the displayed client names
    Then all client names should match the backend and OneDrive data
    And there should be no missing or duplicate clients

  Scenario: Each client card has a Generate Report button
    Given the Clients page is loaded
    When the user inspects each client card
    Then every client card should contain a Generate Report button
    And each button should be enabled by default

  Scenario: Handle OneDrive disconnection gracefully
    Given the user is logged in
    And OneDrive is unavailable or disconnected
    When the user attempts to access client folders
    Then an error message should be displayed
    And the user should be informed of the connection issue


Feature: Circumstance Report Generation

  Scenario: Successful report generation when all required documents exist
    Given the user is logged in
    And the client folder contains Attachments, Statements, Instructions, and a Digital Report
    When the user selects the client folder
    And clicks the Generate button
    Then report generation should start successfully
    And a success notification should be displayed
    And a circumstance report should be generated

  Scenario: Generated report is saved in the output folder
    Given a report has been generated successfully
    When the user navigates to the Output folder
    Then the report should be saved in the Output folder
    And the file name should follow the expected naming convention
    And the report should be accessible

  Scenario: Report generation with multiple attachment files
    Given the client folder contains multiple files in the Attachments folder
    When the user selects the client folder
    And clicks the Generate button
    Then all attachments should be processed
    And the report should be generated successfully
    And no files should be skipped

  Scenario: Report generation with multiple statement documents
    Given multiple statement files exist in the client folder
    When the user selects the folder
    And generates the report
    Then all statement files should be processed
    And the report should include correctly extracted data from all statements

  Scenario: Generate report again for the same client
    Given a report has already been generated for a client
    When the user generates the report again for the same client
    Then the system should create a new report file
    And the previous report should not be overwritten

  Scenario: Report generation completes within acceptable time
    Given the user selects a client folder with a large document set
    When the user clicks the Generate button
    And measures the processing time
    Then the report should be generated within the acceptable SLA
    And no timeout or crash should occur

  Scenario: Generate Report button shows submitting state during processing
    Given the user is on the Clients page
    When the user clicks the Generate Report button
    Then the button should display a submitting state
    And duplicate clicks should be prevented
    And the button should re-enable after completion


Feature: AI Report Content Validation

  Scenario: Report contains all required sections in correct order
    Given a statement document is uploaded
    And attachments, instructions, and a digital report are available
    When the user generates the report
    And opens the generated circumstance report
    Then the report should contain all sections in the following order:
      | Section                       |
      | Cover Page                    |
      | Table of Contents             |
      | Executive Summary             |
      | Summary of Investigation      |
      | Employer Details              |
      | Claimant Profile              |
      | Social Media & Digital Intelligence |
      | System of Work                |
      | Chronology & Circumstances    |
      | Inconsistencies               |
      | Contribution & Recovery       |
      | Listing of Attachments        |
      | Statements                    |

  Scenario: AI correctly extracts claimant metadata
    Given the statement file contains claimant information
    When the user generates the report
    And checks the Cover Page fields
    Then all fields should be correctly extracted from the documents
    And there should be no missing values
    And there should be no hallucinated values
    And values should be correctly mapped from the statement text

  Scenario: AI generates a meaningful executive summary
    Given the statement contains employment and injury details
    When the user generates the report
    And opens the Executive Summary section
    Then the summary should include the claimant's role and employer
    And the summary should include injury context
    And all placeholders should be replaced with real values
    And no fabricated information should be present

  Scenario: AI correctly extracts witness details
    Given witness statements exist in the uploaded files
    When the user generates the report
    And opens the Summary of Investigation section
    Then all witnesses should be listed
    And the witness details should be in the correct structured format
    And any refusal to provide information should be captured
    And no witness entries should be missing

  Scenario: AI correctly extracts employer information
    Given employer information exists in the uploaded documents
    When the user generates the report
    And checks the Employer Details section
    Then the correct company name should be extracted
    And contact details should be accurate
    And employer data should not be mixed with claimant data

  Scenario: AI generates a complete claimant profile
    Given claimant information exists in the statement document
    When the user generates the report
    And opens the Claimant Profile section
    Then all 12 profile fields should be populated correctly
    And pre-existing conditions should be included if present
    And secondary employment should be correctly identified
    And medical practitioners should be listed in a structured format

  Scenario: Social media and digital intelligence section is embedded correctly
    Given a digital report exists
    When the user generates the report
    And navigates to the Social Media section
    Then the digital report should be inserted intact
    And no content should be truncated
    And the format should be preserved

  Scenario: AI correctly extracts the system of work
    Given the statement contains a description of work duties
    When the user generates the report
    And opens the System of Work section
    Then duties should be listed clearly
    And no irrelevant information should be added
    And the content should match the statement

  Scenario: AI produces an accurate chronology and injury timeline
    Given statements and attachments contain dates and events
    When the user generates the report
    And opens the Chronology section
    Then events should be sorted in chronological order
    And dates and times should be correctly extracted
    And no incidents should be missing
    And no duplicate events should be present

  Scenario: AI identifies inconsistencies between statements
    Given conflicting statements exist in the uploaded files
    When the user generates the report
    And checks the Inconsistencies section
    Then contradictions between statements should be identified
    And differences should be clearly listed
    And no false inconsistencies should be created

  Scenario: AI correctly identifies contribution and recovery details
    Given a third party is mentioned in the statement
    When the user generates the report
    And opens the Contribution section
    Then the third party should be correctly identified
    And their relationship to the claim should be explained
    And no incorrect attribution should be present

  Scenario: All attachments are listed in the report
    Given multiple attachments have been uploaded
    When the user generates the report
    And opens the Listing of Attachments section
    Then all attachments should be listed
    And no files should be missing
    And file names should be correct

  Scenario: Table of contents is generated accurately
    Given a report has been generated
    When the user opens the Table of Contents
    And cross-checks against page numbers
    Then all sections should be listed
    And page numbers should be correct
    And no headings should be missing

  Scenario: AI does not hallucinate or fabricate data
    Given only partial data is available in the uploaded documents
    When the user generates the report
    And validates unknown or missing fields
    Then missing data should be shown as blank or "Not Provided"
    And no invented names, dates, or claims should appear in the report

  Scenario: AI correctly merges data from multiple documents
    Given a multi-source dataset is uploaded
    When the user generates the report
    And cross-checks the merged output
    Then there should be no duplication conflicts
    And sources should be correctly prioritized
    And witness and claimant data should be properly merged

  Scenario: Report formatting is consistent throughout
    Given a report has been generated
    When the user reviews the full report
    And checks headings, numbering, and tables
    Then heading styles should be consistent throughout
    And page numbering should be correct and sequential
    And table structures should be uniform


Feature: Report History

  Scenario: Report History tab loads correctly
    Given the user is logged in
    When the user clicks the Report History tab
    Then the tab should load without errors
    And each report entry should display the client name
    And a status badge (success or failed) should be shown
    And start and finish timestamps should be visible
    And a report ID should be displayed

  Scenario: Report card displays correct information
    Given at least one report has been generated
    When the user opens the Report History tab
    And views a report card
    Then the report card should display all expected fields correctly

  Scenario: Status badges correctly reflect report outcomes
    Given reports exist with both success and failure statuses
    When the user opens the Report History tab
    And views the status labels
    Then successful reports should show a green success badge
    And failed reports should show an error or failed status
    And the displayed status should match the backend result

  Scenario: Processing flags correctly indicate document status
    Given a generated report exists
    When the user opens the Report History tab
    And checks the processing indicators for a report
    Then a tick mark should be shown for processed documents
    And a cross mark should be shown for missing or unprocessed documents
    And the indicators should be correctly mapped per category (Statements, Attachments, Instructions, Digital Report)

  Scenario: Clicking a report card shows a detailed audit trail
    Given a generated report exists in Report History
    When the user clicks on a report card
    Then the audit details should expand correctly
    And the processed file list should be displayed
    And all file names should be readable and accurate

  Scenario: Filtering reports by date shows correct results
    Given multiple reports exist across different dates
    When the user opens the Report History tab
    And changes the date filter
    Then only reports from the selected date should be shown
    And the UI should update dynamically
    And no unrelated reports should be displayed

  Scenario: No reports message shown when date range is empty
    Given no reports exist for the selected date
    When the user opens the Report History tab
    And selects an empty date range
    Then a message such as "No reports generated on [date]" should be displayed
    And the page should not crash
    And the filter should remain usable


Feature: UI Behaviour and Navigation

  Scenario: Data refreshes correctly after new report is generated
    Given a new report has been generated externally
    When the user clicks the refresh icon
    Then the latest data should be loaded
    And the UI should update without a full page reload
    And no duplicate entries should appear

  Scenario: Tab switching preserves state correctly
    Given the user is logged in
    When the user clicks the Clients tab
    And then clicks the Report History tab
    And switches back to the Clients tab
    Then navigation should be smooth between tabs
    And state should be preserved correctly
    And no page reload errors should occur

  Scenario: UI handles long client names without breaking layout
    Given a client with a long name exists
    When the user loads the Clients page
    Then the client name text should be truncated or wrapped properly
    And the UI layout should not be broken
    And button alignment should remain intact
