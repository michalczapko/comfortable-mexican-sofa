require File.expand_path('../test_helper', File.dirname(__FILE__))

class RoutingExtensionsTest < ActionDispatch::IntegrationTest
  
  def teardown
    reset_config
    Rails.application.reload_routes!
  end
  
  def test_get_admin_with_admin_route_prefix
    ComfortableMexicanSofa.config.admin_route_prefix = 'custom-admin'
    Rails.application.reload_routes!
    
    http_auth :get, '/cms-admin/sites'
    assert_response 404
    
    http_auth :get, '/custom-admin/sites'
    assert_response :success
  end
  
  def test_get_admin_with_admin_route_redirect
    ComfortableMexicanSofa.config.admin_route_redirect = '/cms-admin/sites'
    Rails.application.reload_routes!
    
    http_auth :get, '/cms-admin'
    assert_response :redirect
    assert_redirected_to cms_admin_sites_path
  end
  
  def test_get_admin_with_admin_route_prefix_disabled
    ComfortableMexicanSofa.config.admin_route_prefix = ''
    Rails.application.reload_routes!
    
    http_auth :get, '/cms-admin'
    assert_response 404
  end
  
end