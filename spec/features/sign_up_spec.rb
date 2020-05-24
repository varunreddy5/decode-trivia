require "rails_helper"

feature "User Signs up" do
  scenario "with valid name, email and password" do
    sign_up_with "test@example.com", "test@123"
    expect(page).to have_content('Logout')
  end

  scenario "with invalid email" do
    sign_up_with "test_email", "test@123"
    expect(page).to have_content('Login')
  end

  scenario "with blank password" do
    sign_up_with "test@example.com", ""
    expect(page).to have_content("Password can't be blank")
  end

  def sign_up_with(email, password)
    visit new_user_registration_path
    fill_in "Name", with: "Test User"
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password Confirmation", with: password
    click_on "Sign up"
  end

 
end
