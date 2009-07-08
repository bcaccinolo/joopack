require File.dirname(__FILE__) + '/../../test_helper'
require 'modies/text_controller'

# Re-raise errors caught by the controller.
class Modies::TextController; def rescue_action(e) raise e end; end

class Modies::TextControllerTest < Test::Unit::TestCase
  fixtures :mody_texts

  def setup
    @controller = Modies::TextController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = mody_texts(:first).id
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

    assert_not_nil assigns(:mody_texts)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:mody_text)
    assert assigns(:mody_text).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:mody_text)
  end

  def test_create
    num_mody_texts = ModyText.count

    post :create, :mody_text => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_mody_texts + 1, ModyText.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:mody_text)
    assert assigns(:mody_text).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      ModyText.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ModyText.find(@first_id)
    }
  end
end
