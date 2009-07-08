require File.dirname(__FILE__) + '/../test_helper'
require 'experiences_controller'

# Re-raise errors caught by the controller.
class ExperiencesController; def rescue_action(e) raise e end; end

class ExperiencesControllerTest < Test::Unit::TestCase
  fixtures :experiences

  def setup
    @controller = ExperiencesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = experiences(:first).id
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

    assert_not_nil assigns(:experiences)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:experience)
    assert assigns(:experience).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:experience)
  end

  def test_create
    num_experiences = Experience.count

    post :create, :experience => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_experiences + 1, Experience.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:experience)
    assert assigns(:experience).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Experience.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Experience.find(@first_id)
    }
  end
end
