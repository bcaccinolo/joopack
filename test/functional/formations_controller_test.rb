require File.dirname(__FILE__) + '/../test_helper'
require 'formations_controller'

# Re-raise errors caught by the controller.
class FormationsController; def rescue_action(e) raise e end; end

class FormationsControllerTest < Test::Unit::TestCase
  fixtures :formations

  def setup
    @controller = FormationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = formations(:first).id
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

    assert_not_nil assigns(:formations)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:formation)
    assert assigns(:formation).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:formation)
  end

  def test_create
    num_formations = Formation.count

    post :create, :formation => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_formations + 1, Formation.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:formation)
    assert assigns(:formation).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Formation.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Formation.find(@first_id)
    }
  end
end
