Feature: User
    In order to verify the processus for reseting a password
    As a visitor
    I want to reset my password

    Background:
       Given I have a user with this following:
            | email     | guirec.corbel@gmail.com   |
            | username  | dougui                    |


    Scenario Outline: I fill the form for reset my password
        Given I am on the new user reset password page

        When I fill in the following:
            | Adresse de courriel  | <email_filled> |
        And I press "Valider"

        Then I should see "<message>"
        
        Examples:
            | email_filled              | message                                                                                               |
            | guirec.corbel@gmail.com   | Un courriel de confirmation vous a été envoyé. Vous devez suivre les étapes indquées pour continuer   |
            | bliblablou@gmail.com      | Cette adresse de courriel n'est pas enregistrée.                                                      |


    @mailer
    Scenario: I receive an email when I want to reset my password
        Given I am on the new user reset password page

        When I fill in the following:
            | Adresse de courriel  | guirec.corbel@gmail.com |
        And I press "Valider"

        Then I should receive an email
        And I should see a link for dougui's reset password page in the email body
        And I should see "Activation de votre compte" in the email subject



    Scenario Outline: I update the password
        Given I am a logged user with this following:
            | active    | true          |
        Given I am on dougui's reset password page

        When I fill in the following:
            | Mot de passe                  | <password> |
            | Mot de passe (confirmation)   | <password> |
        And I press "Valider"

        And I should see "<message>"

        Examples:
            | password  | message                               |
            | test123   | Votre mot de passe a été modifié      |
            |           | est trop court (au moins 4 caractères)|
