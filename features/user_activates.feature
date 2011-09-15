Feature: User
    In order to verify the activation processus
    As a visitor
    I want to activate my account

    Scenario: Activate my account
        Given I have a user with this following:
            | username  | dougui |
            | active    | false  |
        When I go to dougui's activate page
        Then I should have a user with this following:
            | username  | dougui    |
            | active    | true      |
