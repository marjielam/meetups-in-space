require 'spec_helper'

feature "User visits show page" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let(:user2) do
    User.create(
      provider: "github",
      uid: "2",
      username: "jarlax2",
      email: "jarlax2@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let!(:location) do
    Location.create(
      name: "Jupiter",
      address: "5 planets from the sun"
    )
  end

  let!(:meetup) do
    Meetup.create(
      name: "Space Meetup",
      description: "Talk about things",
      location: location,
      creator: user
    )
  end

  scenario "user sees list of users already signed up for meetup" do
    visit '/'
    sign_in_as user
    visit '/meetups/' + meetup.id.to_s
    click_button 'Sign Up'
    click_link "Sign Out"

    visit '/'
    sign_in_as user2
    visit '/meetups/' + meetup.id.to_s
    click_button 'Sign Up'

    expect(page).to have_content "jarlax1"
    expect(page).to have_content "jarlax2"
    expect(page).to have_xpath("//img")

  end

  scenario "user cannot sign up for meetup if they are not signed in" do
    visit '/meetups/' + meetup.id.to_s
    click_button 'Sign Up'

    expect(page).to have_content "You must sign in before signing up for an event."
  end

  scenario "user can sign up for meetup" do
    visit '/'
    sign_in_as user
    visit '/meetups/' + meetup.id.to_s
    click_button 'Sign Up'

    expect(page).to have_content "jarlax1"
    expect(page).to have_xpath("//img")
  end
end
