require 'factory_girl_rails'

RSpec.configure do |c|
  c.include FactoryGirl::Syntax::Methods
  c.alias_example_to :expect_it
end

RSpec::Core::MemoizedHelpers.module_eval do
  alias to should
  alias to_not should_not
  alias not_to should_not
end