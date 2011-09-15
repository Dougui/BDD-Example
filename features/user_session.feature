Feature: User
    In order to control the connection system
    As a valid user
    I want to connect and disconnect a user

    Scenario Outline: Login a valid user
        Given I have a user with this following:
            | username              | dougui    |
            | password              | test      |
            | password_confirmation | test      |
            | active                | <active>  |
        And I am on the login page

        When I fill in the following:
            | Pseudo        | <username_filled> |
            | Mot de passe  | <password_filled> |
        And I press "Se connecter"

        And I should see "<message>"

    Examples:
        | username_filled   | password_filled | active  | message                       |
        | dougui            | test            | true    |                               |
        | dougui1           | test            | true    | n'est pas valide              |
        | dougui            | test            | false   | Votre compte n'est pas actif  |
        |                   | test            | true    | doit être rempli(e)           |
        | dougui            |                 | true    | doit être rempli(e)           |

    Scenario: Disconnect a user connected
        Given I am a logged user
        And I follow "Se déconnecter"

        Then I should be on the home page

        And I should see "Se connecter"