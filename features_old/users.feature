Feature: User
    In order to create a website
    As a visitor
    I want to create a list of users

    Scenario: Create a new user
        Given I have no users
        And I am on the register page
        When I fill in "user_username" with "dougui"
        And I fill in "user_email" with "guirec.corbel@gmail.com"
        And I fill in "user_password" with "dougui"
        And I fill in "user_password_confirmation" with "dougui"
        And I press "user_submit"
        Then I should see "Vous avez été enregistré. Un courriel de confirmation vous a été envoyé. Vous devez confirmer votre inscription pous continuer."
        And I should have 1 user

    Scenario: Create a new user
        Given I have no users
        And I am on the register page
        Then I should have a xpath ".//input[@type='password' and @id='user_password_confirmation']"
        And I should have a xpath ".//input[@type='password' and @id='user_password']"
        When I fill in "user_username" with "dougui"
        And I fill in "user_email" with "guirec.corbel"
        And I fill in "user_password" with "dougui"
        And I fill in "user_password_confirmation" with "dougui"
        And I press "user_submit"
        Then I should see "ne semble pas être une adresse de courriel valide."
        And I should not see "Le Email L'adresse de courriel ne semble pas être une adresse de courriel valide."
        When I fill in "user_email" with "guirec.corbel@gmail.com"
        And I press "user_submit"
        Then I should be on the login page
        And I should see "Vous avez été enregistré. Un courriel de confirmation vous a été envoyé. Vous devez confirmer votre inscription pous continuer."
        When I go to the user_activates new page with username dougui
        Then I should see "Votre compte à été activé. Vous pouvez vous connecter."

    Scenario: Log a user
        Given a valid user exists
        And I am on the login page
        Then I should have a password field named "user_session_password"
        When I press "user_session_submit"
        Then I should see "Vous n'avez pas fournis les details pour vous authentifier."
        When I fill in "user_session_password" with "test"
        And I press "user_session_submit"
        Then I should see "doit être rempli"
        And I should not see "Le Username doit être rempli"
        When I fill in "user_session_username" with "test"
        And I fill in "user_session_password" with "test"
        And I press "user_session_submit"
        Then I should be on the home page

    Scenario: View the home page when not logged
        When I am on the home page
        Then I should see "S'inscrire"
        Then I should see "Me rappeler mon not de passe"
        Then I should see "Se connecter"

    Scenario: View the home page when logged
        Given I am a logged user
        When I am on the home page
        Then I should see "Supprimer mon compte"
        Then I should see "Se déconnecter"
        Then I should see "Modifier mon compte"

    Scenario: Edit my account
        Given I am a logged user
        When I am on the edit user page with id 1
        Then the "user_username" field should contain "test"
        And the "user_email" field should contain "test@test.com"
        When I fill in "user_email" with ""
        And I press "user_submit"
        Then I should see "ne semble pas être une adresse de courriel valide."
        When I fill in "user_username" with "test1"
        And I fill in "user_email" with "test@test1.com"
        And I press "user_submit"
        Then I should be on the home page
        And the user 1 must have "test1" as "username"
        And I should see "Votre compte à été modifié"

    Scenario: Edit my password
        Given I am a logged user
        When I am on the edit user page with id 1
        And I follow "Modifier le mot de passe"
        And I fill in "user_password" with "test1"
        And I fill in "user_password_confirmation" with "test2"
        And I press "user_submit"
        Then I should see "ne concorde pas avec la confirmation"
        When I fill in "user_password_confirmation" with "test1"
        And I press "user_submit"
        Then I should be on the home page
        And I should see "Votre mot de passe à été modifié"

    Scenario: Reset my password
        Given I have a valid user
        When I am on the user password resets new page
        And I fill in "user_email" with "toto"
        And I press "user_submit"
        Then I should see "ne semble pas être une adresse de courriel valide."
        And I fill in "user_email" with "test@test.com"
        And I press "user_submit"
        Then I should be on the login page
        And I should see "Un courriel de confirmation vous a été envoyé. Vous devez suivre les étapes indquées pour continuer."

    Scenario: Logout
        Given I am a logged user
        And I am on the home page
        When I follow "Se déconnecter"
        Then I should be on the home page
        And I should see "Se connecter"

    Scenario: Delete my account
        Given I am a logged user
        When I am on the root page
        And I follow "Supprimer mon compte"
        Then I should be on the home page
        And I should have 0 user