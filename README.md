# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.
check it live @ https://fast-fortress-80919.herokuapp.com/

----------------------------------notes--------------------------------------------------------------------------------------
This app utilizes a free version of the Heroku addon Mail Gun. This addon provide email functionality and being as it is free, a user of the app must contact me to add their email to the 'authorized email list' (a limitation of the free version) in order for their experience to be great. If this is not desired, I invite you to log in as the dummy user with credentials below to enjoy the best possible user experience (app and gmail credentials):
---------------------------------------
| email: lhl.johnny.johnson@gmail.com |
| pw: lighthouse123                   |
---------------------------------------
Thankyou!
-----------------------------------------------------------------------------------------------------------------------------

##contributions

#nav bar
 -added a signup button (redirects)
   -simple signup form added here which authenticates and digests password via bcrypt hash
   -any errors display above form
 -added a login button which triggers (a ugly) a modal login form
   -any error messages will appear in modal, above form
   -upon success, the login button is replaced with a friendly message and a logout button

#admin panel
 -added http basic authentication for admin dropdown options
   -admin dashboard not functional*
   -admin category panel allows for creation and update of categories to be used to create products
   -admin product panel allows for the creation of products
     -fixed bug where server would crash if admin attempted to delete an item that had been sold at some point in the past
     -removed the ability for admin to assign a negative quantity to products upon creation
     -see commit history for more details..
    
#at root '/'

 -products display sold-out if their inventory is 0, additonally the add-to-cart button would be removed for that scenario
 -under product image's, ratings for that product are displayed as an average based on number of reviews

#at product show '/products/:id
  -detailed description of product now contains the average rating given to that product by users
  -added logic to prevent a guest user from creating reviews
   -this logic is doubled up by disabling the review toggle button (if they make it visible) 
      -on the back end a review will not successfully post if not logged and instead will display an error 
       by the review form
  -if user is logged in, a (ugly) review button will be visible which will toggle login form that contains a text field
    and a review selector which defaults to 1, error messages will appear above form
  -posted comments appear below with most recent being at the top
    -a logged in user may choose to delete his or her comment by selecting the garbage icon on the bottom right of their    
      review(this icon is only visible for the user's comments)
#at cart '/cart'
  -changed logic on incrementing and decrimenting product quantity: if desired quantity is = to product inventory the      
    increment button disappears
    -again this is doubled up with logic on the back end that returns an error message for that line item which explains
     why the order could not be processed *see cart model
  -pay with card now correctly displays the user email address, and incase user is a guest it display a dummy email address 
    'default@mail.com'.
  ******please note that continuing with this purchase in heroku will return an error due to reasons    
     explained above with Mail Gun free version
  
  -upon successful order completion, a summary is formatted and displayed on the screen for the user and similar results 
  are sent to the user's email
     -fixed bug where purchasing a product did not have a reflection on that products inventory in the database
     -fixed bug that allowed purchasing more of a product than is available in the inventory
     
     **please see commit history for more changes**
     
**future changes**
  -develop admin dashboard
  -configure carrierwave to persist images uploaded to heroku
  -*need to add more here*
  
    
## Setup

1. Fork & Clone
2. Run `bundle install` to install dependencies
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
