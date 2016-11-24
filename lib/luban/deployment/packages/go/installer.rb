module Luban
  module Deployment
    module Packages
      class Go < Luban::Deployment::Package::Base
        class Installer < Luban::Deployment::Package::Installer
          define_executable 'go'

          def package_dist; task.opts.dist; end
          def package_full_name; "go#{package_version}.#{package_dist}"; end

          def source_repo
            @source_repo ||= 'https://storage.googleapis.com'
          end

          def source_url_root
            @source_url_root ||= "golang"
          end

          def installed?
            return false unless file?(go_executable)
            pattern = Regexp.new(Regexp.escape("go version go#{package_version}"))
            match?("GOROOT=#{install_path} #{go_executable} version 2>&1", pattern)
          end

          def build_path
            @build_path ||= package_tmp_path.join("go")
          end

          protected

          def build_package
            info "Building #{package_full_name}"
            within install_path do
              execute(:mv, build_path.join('*'), '.', ">> #{install_log_file_path} 2>&1")
            end
          end
        end
      end
    end
  end
end

