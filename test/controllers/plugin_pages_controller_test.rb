require 'test_helper'

class PluginPagesControllerTest < ActionController::TestCase
  setup do
    @plugin_page = plugin_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plugin_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plugin_page" do
    assert_difference('PluginPage.count') do
      post :create, plugin_page: { body: @plugin_page.body, plugin_id: @plugin_page.plugin_id, title: @plugin_page.title }
    end

    assert_redirected_to plugin_page_path(assigns(:plugin_page))
  end

  test "should show plugin_page" do
    get :show, id: @plugin_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plugin_page
    assert_response :success
  end

  test "should update plugin_page" do
    patch :update, id: @plugin_page, plugin_page: { body: @plugin_page.body, plugin_id: @plugin_page.plugin_id, title: @plugin_page.title }
    assert_redirected_to plugin_page_path(assigns(:plugin_page))
  end

  test "should destroy plugin_page" do
    assert_difference('PluginPage.count', -1) do
      delete :destroy, id: @plugin_page
    end

    assert_redirected_to plugin_pages_path
  end
end
