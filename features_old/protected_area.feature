Feature: Manage Protected
    In order to control who can access my protected areas
    As a visitor
    I want to acces to protected areas

    Background:
        Given a user exist with id: "1"

    Scenario: Acces to protected Area
        Then I couldn't access to the users edit page with id 1
        Then I couldn't access to the users update page with id 1 with method put
        Then I couldn't access to the users destroy page with id 1 with method delete
        Then I couldn't access to the user_sessions destroy page with id 1 with method delete


 