require "rails_helper"

feature "User Signs In" do
  scenario "with valid email and password" do
    user = FactoryBot.create(:user)
    sign_in_with(user.email, user.password)
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "with invalid email or password" do
    sign_in_with "test", ""
    expect(page).to have_content("Invalid Email or password.")
  end

  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on 'Sign In'
  end
end