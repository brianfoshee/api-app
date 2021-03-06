require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  setup do
    @todo = todos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post :create, params: { todo: { isCompleted: @todo.isCompleted, title: @todo.title } }
    end

    assert_response 201
  end

  test "should show todo" do
    get :show, params: { id: @todo }
    assert_response :success
  end

  test "should update todo" do
    patch :update, params: { id: @todo, todo: { isCompleted: @todo.isCompleted, title: @todo.title } }
    assert_response 200
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete :destroy, params: { id: @todo }
    end

    assert_response 204
  end
end
