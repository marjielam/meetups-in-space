require 'spec_helper'

feature "User creates new meetup" do

  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "clicks on Create a new meetup button" do
    visit '/'
    sign_in_as user
    click_link "Create a New Meetup"

    expect(page).to have_content "Create a New Meetup"
    expect(find("form")).to be_present
  end

  scenario "successfully creates new meetup" do
    visit '/'
    sign_in_as user
    click_link "Create a New Meetup"

    fill_in('Event Name', :with => 'Podcast lovers')
    fill_in('Location Name', :with => 'Jupiter')
    fill_in('Location Address', :with => 'Fifth planet from the sun')
    fill_in('Description', :with => 'Come talk about podcasts!')
    click_button('Create Meetup')

    expect(page).to have_content "You successfully created a new meetup!"
    expect(page).to have_content('Podcast lovers')
    expect(page).to have_content('Description: Come talk about podcasts!')
  end

  scenario "user is not signed in and tries to create a meetup" do
    visit '/'
    click_link "Create a New Meetup"

    fill_in('Event Name', :with => 'Podcast lovers')
    fill_in('Location Name', :with => 'Jupiter')
    fill_in('Location Address', :with => 'Fifth planet from the sun')
    fill_in('Description', :with => 'Come talk about podcasts!')
    click_button('Create Meetup')

    expect(page).to have_content('Please sign in before creating an event.')
  end


  scenario "fails to enter a name for a new meetup" do
    visit '/'
    sign_in_as user
    click_link "Create a New Meetup"

    fill_in('Location Name', :with => 'Jupiter')
    fill_in('Location Address', :with => 'Fifth planet from the sun')
    fill_in('Description', :with => 'Come talk about podcasts!')
    click_button('Create Meetup')

    expect(find("form")).to be_present
    expect(page).to have_content('Please enter an event name.')
  end

  scenario "fails to enter a location name for a new meetup" do
    visit '/'
    sign_in_as user
    click_link "Create a New Meetup"

    fill_in('Event Name', :with => 'Podcast Lovers')
    fill_in('Location Address', :with => 'Fifth planet from the sun')
    fill_in('Description', :with => 'Come talk about podcasts!')
    click_button('Create Meetup')

    expect(find("form")).to be_present
    expect(page).to have_content('Please enter a location name.')
  end

  scenario "fails to enter a description for a new meetup" do
    visit '/'
    sign_in_as user
    click_link "Create a New Meetup"

    fill_in('Event Name', :with => 'Podcast Lovers')
    fill_in('Location Name', :with => 'Jupiter')
    fill_in('Location Address', :with => 'Fifth planet from the sun')
    click_button('Create Meetup')

    expect(find("form")).to be_present
    expect(page).to have_content('Please enter a description for your event.')
  end

end
