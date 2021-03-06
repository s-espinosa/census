require 'rails_helper'

RSpec.describe "General Search API" do
  context  "GET api/v1/users/search" do
    it "searches by cohort and returns users with first, last and groups" do
      cohort_1, cohort_2 = create_list(:cohort, 2)
      users = create_list(:user, 3)
      users.first.cohort = cohort_1
      users.second.cohort = cohort_1
      users.third.cohort = cohort_2
      group = create(:group, users: users)

      params = {q: cohort_1.name}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)
      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
      end

      last = json_users.any? do |user|
        user["last_name"] == users.first.last_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)

    end
  end
  context  "GET api/v1/users/search" do
  it "returns users matching cohort partial search query" do
    cohort_1 = create(:cohort, name: "1608")
    cohort_2 = create(:cohort, name: "1610")
    cohort_3 = create(:cohort, name: "1701")


    users = create_list(:user, 3)
    users.first.cohort = cohort_1
    users.second.cohort = cohort_2
    users.third.cohort = cohort_3
    group = create(:group, users: users)

    params = {q: "16"}
    get "/api/v1/users/search_all", params: params

    json_users = JSON.parse(response.body)

    expect(json_users.count).to eq(2)

    first = json_users.any? do |user|
      user["first_name"] == users.first.first_name
      user["first_name"] == users.second.first_name
    end

    expect(first).to be_truthy

  end
end
  context  "GET api/v1/users/search" do
    it "searches by role and returns users with first, last and groups" do
      role_1, role_2 = create_list(:role, 2)
      users = create_list(:user, 3)
      users.first.roles << role_1
      users.second.roles << role_1
      users.third.roles << role_2
      group = create(:group, users: users)

      params = {q: role_1.name}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
      end

      last = json_users.any? do |user|
        user["last_name"] == users.first.last_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)

    end
  end
  context  "GET api/v1/users/search" do
    it "searches by partial role query" do
      role_1 = create(:role, name: "fakerole")
      role_2 = create(:role, name: "fakerole2")
      role_3 = create(:role, name: "admin")
      users = create_list(:user, 3)
      users.first.roles << role_1
      users.second.roles << role_2
      users.third.roles << role_3
      group = create(:group, users: users)

      params = {q: "fakerole"}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
        user["first_name"] == users.second.first_name
      end

      expect(first).to be_truthy

    end
  end
  context  "GET api/v1/users/search" do
    it "searches by group and returns users with first, last and groups" do
      group_1, group_2 = create_list(:group, 2)
      users = create_list(:user, 3)
      users.first.groups << group_1
      users.second.groups << group_1
      users.third.groups << group_2

      params = {q: group_1.name}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
      end

      last = json_users.any? do |user|
        user["last_name"] == users.first.last_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group_1.name)

    end
  end
  context  "GET api/v1/users/search" do
    it "searches by partial group" do
      group_1 = create(:group, name: "fakegroup")
      group_2 = create(:group, name: "fakegroup2")
      group_3 = create(:group, name: "Turing Lab")
      users = create_list(:user, 3)
      users.first.groups << group_1
      users.second.groups << group_2
      users.third.groups << group_3

      params = {q: "fakegroup"}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
        user["first_name"] == users.second.first_name

      end

      expect(first).to be_truthy

    end
  end
  context  "GET api/v1/users/search" do
    it "searches by first_name and returns users with first, last and groups" do
      user_1 = create(:user, first_name: "brad")
      user_2 = create(:user, first_name: "brad")
      user_3 = create(:user, first_name: "ali")
      group = create(:group, users: [user_1, user_2, user_3])

      params = {q: "brad"}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.all? do |user|
        user["first_name"] == "brad"
      end

      last = json_users.any? do |user|
        user["last_name"] == user_1.last_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)
    end
  end
  context  "GET api/v1/users/search" do
    it "searches by partial name" do
      user_1 = create(:user, first_name: "gibberish")
      user_2 = create(:user, last_name: "gibberish")
      user_3 = create(:user, first_name: "brad", last_name: "green")
      group = create(:group, users: [user_1, user_2, user_3])

      params = {q: "gibberish"}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == user_1.first_name
        user["last_name"] == user_2.last_name

      end

      expect(first).to be_truthy

    end
  end
  context  "GET api/v1/users/search" do
    it "searches by last_name and returns users with first, last and groups" do
      user_1 = create(:user, last_name: "schlereth")
      user_2 = create(:user, last_name: "schlereth")
      user_3 = create(:user, last_name: "green")
      group = create(:group, users: [user_1, user_2, user_3])

      params = {q: "schlereth"}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      last = json_users.all? do |user|
        user["last_name"] == "schlereth"
      end

      first = json_users.any? do |user|
        user["first_name"] == user_1.first_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)
    end
  end
end
