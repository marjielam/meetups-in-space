require 'spec_helper'

feature "User visits meetups index page" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
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

  let!(:meetup2) do
    Meetup.create(
      name: "Another One on Jupiter",
      description: "Do things",
      location: location,
      creator: user
    )
  end

  scenario "sees list of meetups" do
    visit '/'
    sign_in_as user

    expect(page).to have_content "Space Meetup"
    expect(page).to have_content "Another One on Jupiter"
  end

  scenario "list of meetups is alphabetical" do
    visit '/'
    sign_in_as user

    expect(find(".meetups li:nth-child(1)")).to have_content "Another"
    expect(find(".meetups li:nth-child(2)")).to have_content "Space Meetup"
  end

  scenario "clicks on meetup" do
    visit '/'
    sign_in_as user
    click_link "Space Meetup"

    expect(page).to have_content meetup.name
    expect(page).to have_content meetup.location.name
    expect(page).to have_content meetup.location.address
    expect(page).to have_content meetup.description
    expect(page).to have_content meetup.creator.username
    expect(page).to_not have_content "You successfully created a new meetup!"
  end

  scenario "clicks on Create a new meetup button" do
    visit '/'
    sign_in_as user
    click_link "Create a New Meetup"

    expect(page).to have_content "Create a New Meetup"
    expect(find("form")).to be_present
  end
end
