require File.dirname(__FILE__) + '/../test_helper'
require 'hobbies_controller'

# Re-raise errors caught by the controller.
class HobbiesController; def rescue_action(e) raise e end; end

class HobbiesControllerTest < Test::Unit::TestCase
  fixtures :hobbies

  def setup
    @controller = HobbiesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = hobbies(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:hobbies)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:hobby)
    assert assigns(:hobby).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:hobby)
  end

  def test_create
    num_hobbies = Hobby.count

    post :create, :hobby => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_hobbies + 1, Hobby.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:hobby)
    assert assigns(:hobby).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Hobby.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Hobby.find(@first_id)
    }
  end
end
