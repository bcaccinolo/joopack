require File.dirname(__FILE__) + '/../test_helper'
require 'moovers_datas_controller'

# Re-raise errors caught by the controller.
class MooversDatasController; def rescue_action(e) raise e end; end

class MooversDatasControllerTest < Test::Unit::TestCase
  fixtures :moovers_datas

  def setup
    @controller = MooversDatasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = moovers_datas(:first).id
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

    assert_not_nil assigns(:moovers_datas)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:moovers_data)
    assert assigns(:moovers_data).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:moovers_data)
  end

  def test_create
    num_moovers_datas = MooversData.count

    post :create, :moovers_data => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_moovers_datas + 1, MooversData.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:moovers_data)
    assert assigns(:moovers_data).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      MooversData.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MooversData.find(@first_id)
    }
  end
end
