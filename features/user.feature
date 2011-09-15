Feature: User
    In order to manage my account
    As a visitor
    I want to manage my account

    @autotest
    Scenario Outline: Create a new account
        Given I have no users
        And I am on the new user page

        When I fill in the following:
            | Pseudo                        | <pseudo>                    |
            | Adresse de courriel           | <email>                     |
            | Mot de passe                  | <password>                  |
            | Mot de passe (confirmation)   | <password_confirmation>     |
        And I press "S'inscrire"

        Then I should see "<message>"
        And I should have <nb_users> user

        Examples:
          | pseudo  | email                     | password      | password_confirmation   | message                                                                                                                         | nb_users  |
          | dougui  | guirec.corbel@gmail.com   | test1234      | test1234                | Vous avez été enregistré. Un courriel de confirmation vous a été envoyé. Vous devez confirmer votre inscription pour continuer. | 1         |
          |         | guirec.corbel@gmail.com   | test1234      | test1234                | est trop court (au moins 3 caractères)                                                                                          | 0         |
          | dougui  | guirec.corbel             | test1234      | test1234                | ne semble pas être une adresse de courriel                                                                                      | 0         |
          | dougui  | guirec.corbel@gmail.com   | test1234      | test123                 | ne concorde pas avec la confirmation                                                                                            | 0         |


    @mailer
    Scenario: Send an email when a new user is created
        Given no emails have been sent
        And I have no users
        And I am on the new user page

        When I create a user

        Then I should receive an email
        And I should see a link for dougui's activate page in the email body
        And I should see "Activation de votre compte" in the email subject



   Scenario Outline: Update an account
        Given I am a logged user with this following:
            | active    | true          |
            | username  | <pseudo_old>  |
            | email     | <email_old>   |
        And I am on dougui's edit page

        When I fill in the following:
            | Pseudo                | <pseudo_new>  |
            | Adresse de courriel   | <email_new>   |
        And I press "Valider"

        Then I should have <nb_users> user with this following:
            | username  | <pseudo_new>  |
            | email     | <email_new>   |
        And I should see "<message>"

        Examples:
          | pseudo_old  | email_old                 | pseudo_new    | email_new                 | nb_users  | message                                       |
          | dougui      | guirec.corbel@gmail.com   | dougui1       | guirec.corbel1@gmail.com  | 1         | Votre compte a été modifié                    | 
          | dougui      | guirec.corbel@gmail.com   | dougui        | guirec.corbel             | 0         | ne semble pas être une adresse de courriel    |
          | dougui      | guirec.corbel@gmail.com   |               | guirec.corbel@gmail.com   | 0         | est trop court (au moins 3 caractères)        |


    Scenario: Follow the link to reset password
        Given I am a logged user with username "dougui"

        When I go to dougui's edit page
        And I follow "Modifier le mot de passe"

        Then I should be on dougui's reset password page


    Scenario: Destroy an account
        Given I am a logged user

        When I go to the home page
        And I follow "Supprimer mon compte"


        Then I should have no user
        And I should be on the home page
        And I should see "Votre compte a été supprimé"
        And I should see "S'inscrire"