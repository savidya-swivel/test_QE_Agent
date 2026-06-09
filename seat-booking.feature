Feature: Seat Booking Management

  Background:
    Given the user is authenticated
    And the user navigates to the Seat Booking page

  # ----------------------------------
  # New Booking
  # ----------------------------------

  Scenario: View seat availability for a specific date
    When the user selects a future date
    Then available and unavailable seats are displayed
    And visual indicators distinguish booked and available seats

  Scenario: Select a seat for booking
    Given seat availability is displayed
    When the user selects an available seat
    Then the seat is highlighted
    And the seat ID is stored

  Scenario: Select full-day booking duration
    Given the booking panel is displayed
    When the user selects the "Full Day" option
    Then the booking duration is set from 09:00 to 17:00

  Scenario: Select half-day booking duration
    Given the booking panel is displayed
    When the user selects the "Half Day" option
    Then the booking duration is set to 4 hours

  Scenario: Select custom booking duration
    Given the booking panel is displayed
    When the user enters custom start and end times
    Then the booking duration is accepted if the end time is after the start time

  Scenario: View available time slots
    Given the booking panel is displayed
    When the user opens the time slot dropdown
    Then all 19 time slots between 08:00 and 18:00 are displayed

  Scenario: Select lunch option during meal window
    Given the booking time falls between 12:00 and 14:00
    And the meal cutoff time has not passed
    When the user selects a lunch option
    Then the lunch selection is saved with the booking

  Scenario: Prevent lunch selection after cutoff time
    Given the meal cutoff time has passed
    When the user attempts to select a lunch option
    Then lunch selection is disabled
    And an explanation message is displayed

  Scenario: Create a single-day booking successfully
    Given the user has selected a date, seat, and duration
    When the user clicks "Confirm Booking"
    Then the booking is created successfully
    And a success message is displayed

  Scenario: Display booking confirmation details
    Given a booking has been created successfully
    Then the confirmation message displays the booking date, time, and seat ID

  Scenario: Prevent booking an already booked seat
    Given a seat is already booked for the selected date
    When the user submits a booking for that seat
    Then an error message is displayed indicating the seat is already booked

  Scenario: Prevent booking for a past date
    When the user opens the date picker
    Then past dates are disabled and cannot be selected

  Scenario: Handle booking race condition
    Given the user selected an available seat
    And another user books the same seat before submission
    When the booking is submitted
    Then the booking is rejected
    And an error message is displayed

  Scenario: Create recurring booking
    Given recurring booking is enabled
    When the user selects Monday, Wednesday and Friday
    Then recurring booking details are included in the request

  Scenario: Define recurring booking end date
    Given recurring booking is enabled
    When the user selects an end date
    Then recurring bookings are generated only until that date

  Scenario: Disable recurring booking for proxy booking
    Given the user chooses to book for another employee
    Then recurring booking options are disabled

  Scenario: Book a seat for another employee
    Given the user enables booking for another employee
    When the user selects an employee
    Then the booking is created for the selected employee

  Scenario: Search employees when booking for others
    Given booking for another employee is enabled
    When the user searches by employee name or email
    Then matching employees are displayed

  Scenario: Prevent booking for a non-existent employee
    Given the selected employee does not exist
    When the booking is submitted
    Then an error message is displayed

  Scenario: Prevent duplicate booking for employee
    Given the selected employee already has a booking for the date
    When the booking is submitted
    Then a conflict error is returned

  Scenario: Change office location
    Given multiple office locations are available
    When the user selects a different office
    Then seat availability is refreshed for the selected office

  Scenario: Load default office on page load
    When the booking page loads
    Then the default office is selected

  Scenario: Preselect tomorrow's date
    When the booking page loads
    Then tomorrow's date is selected by default

  # ----------------------------------
  # My Bookings
  # ----------------------------------

  Scenario: View upcoming bookings
    Given the user has upcoming bookings
    When the user navigates to My Bookings
    Then all upcoming bookings are displayed in chronological order

  Scenario: View empty bookings state
    Given the user has no bookings
    When the user navigates to My Bookings
    Then an empty state message is displayed

  Scenario: Load bookings on page entry
    When the user navigates to My Bookings
    Then a loading indicator is displayed
    And booking data is loaded successfully

  Scenario: Display booking details
    Given bookings exist
    Then booking date, office, duration and meal information are displayed correctly

  Scenario: Display only future bookings
    Given the user has past and future bookings
    When the user views My Bookings
    Then only future bookings are displayed

  Scenario: Handle booking retrieval failure
    Given the bookings API fails
    When the user opens My Bookings
    Then an error message is displayed
    And a retry option is available

  # ----------------------------------
  # Cancel Booking
  # ----------------------------------

  Scenario: Cancel a booking successfully
    Given the user has an upcoming booking
    When the user confirms cancellation
    Then the booking is cancelled
    And removed from the booking list

  Scenario: Show cancellation confirmation dialog
    Given the user clicks cancel on a booking
    Then a confirmation dialog is displayed
    And booking details are shown

  Scenario: Dismiss cancellation dialog
    Given the confirmation dialog is displayed
    When the user closes the dialog
    Then the booking remains active

  Scenario: Prevent cancellation of past bookings
    Given a booking date is in the past
    Then the cancel button is disabled

  Scenario: Handle cancellation API failure
    Given the cancellation request fails
    When the user confirms cancellation
    Then an error message is displayed

  # ----------------------------------
  # Edit Meal Option
  # ----------------------------------

  Scenario: Update meal option
    Given an upcoming booking exists
    When the user selects a different meal option
    Then the meal option is updated successfully

  Scenario: Add meal option to booking
    Given no meal option is selected
    When the user selects a meal
    Then the meal preference is saved

  Scenario: Remove meal option
    Given a meal option is selected
    When the user selects "No Meal"
    Then the meal option is removed

  Scenario: Prevent meal editing after cutoff
    Given the meal cutoff time has passed
    Then meal editing is disabled

  Scenario: Edit meal for recurring booking occurrence
    Given a recurring booking exists
    When the user edits the meal for a specific occurrence
    Then only that occurrence is updated

  # ----------------------------------
  # Recurring Booking Cancellation
  # ----------------------------------

  Scenario: Cancel only one occurrence of recurring booking
    Given a recurring booking exists
    When the user selects "Only This Occurrence"
    And confirms cancellation
    Then only the selected booking is cancelled
    And remaining recurring bookings remain active

  Scenario: Cancel entire recurring booking series
    Given a recurring booking exists
    When the user selects "Entire Recurring Booking"
    And confirms cancellation
    Then all bookings in the recurring series are cancelled

  Scenario: Keep recurring booking
    Given a recurring booking exists
    When the user selects "No, Keep Booking"
    Then no bookings are cancelled

  # ----------------------------------
  # Login Booking Reminder
  # ----------------------------------

  Scenario: Display next-day booking reminder
    Given a booking exists for tomorrow
    When the user logs in
    Then the booking management popup is displayed
    And the "Cancel Booking" option is available

  Scenario: Cancel only tomorrow's booking from login popup
    Given a booking exists for tomorrow
    When the user clicks "Cancel Booking"
    Then only tomorrow's booking is cancelled

  Scenario: Do not show reminder when no next-day booking exists
    Given no booking exists for tomorrow
    When the user logs in
    Then the booking management popup is not displayed