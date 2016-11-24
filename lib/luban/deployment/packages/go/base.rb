module Luban
  module Deployment
    module Packages
      class Go < Luban::Deployment::Package::Base
        protected

        def setup_provision_tasks
          super
          provision_tasks[:install].option :dist, "Binary distribution"
        end
      end
    end
  end
end
