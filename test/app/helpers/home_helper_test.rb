require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class NagaInstagramApi::App::HomeHelperTest < Test::Unit::TestCase
  context "NagaInstagramApi::App::HomeHelper" do
    setup do
      @helpers = Class.new
      @helpers.extend NagaInstagramApi::App::HomeHelper
    end

    should "return nil" do
      assert_equal nil, @helpers.foo
    end
  end
end
