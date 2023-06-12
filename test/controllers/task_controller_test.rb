require "test_helper"
require "faker"

class TaskControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  FactoryBot.define do
    factory :task do
      id { Faker::Number.number(digits: 2) }
      name { Faker::Quote.famous_last_words }
      status { "open" }
      created_at { Date.today }
    end
  end

  setup do
    @task = build(:task)
  end

  test "should get index" do
    get api_v1_tasks_url
    assert_response :success
  end

  test "should get create" do
    post api_v1_tasks_url
    assert_response :created
  end

  test "should get update" do
    patch api_v1_task_url(@task)
    assert_response :created
  end

  describe ".index" do
    it "should get index" do
      get api_v1_tasks_url
      assert_response :ok
    end
  end
end
