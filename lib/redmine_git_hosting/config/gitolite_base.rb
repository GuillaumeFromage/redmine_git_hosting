require 'etc'

module RedmineGitHosting
  module Config
    module GitoliteBase
      extend self

      def check_cache
        @gitolite_home_dir        = nil
        @mirroring_keys_installed = nil
        @mirroring_public_key     = nil
        @gitolite_ssh_fingerprint = nil
      end


      def redmine_user
        @redmine_user ||= (%x[whoami]).chomp.strip
      end


      def gitolite_home_dir
        @gitolite_home_dir ||= Etc.getpwnam(gitolite_user).dir rescue nil
      end


      def gitolite_lib_dir
        RedmineGitHosting::Config.get_setting(:gitolite_lib_dir)
      end


      def gitolite_lib_dir_path
        if gitolite_lib_dir.starts_with?('/')
          gitolite_lib_dir
        else
          File.join(gitolite_home_dir, gitolite_lib_dir)
        end
      end


      def gitolite_user
        RedmineGitHosting::Config.get_setting(:gitolite_user)
      end


      def gitolite_server_host
        RedmineGitHosting::Config.get_setting(:gitolite_server_host)
      end


      def gitolite_server_port
        RedmineGitHosting::Config.get_setting(:gitolite_server_port)
      end


      def gitolite_ssh_private_key
        RedmineGitHosting::Config.get_setting(:gitolite_ssh_private_key)
      end


      def gitolite_ssh_public_key
        RedmineGitHosting::Config.get_setting(:gitolite_ssh_public_key)
      end


      def gitolite_ssh_public_key_fingerprint
        @gitolite_ssh_fingerprint ||= RedmineGitHosting::Utils.ssh_fingerprint(File.read(gitolite_ssh_public_key))
      end


      def gitolite_config_file
        File.basename(RedmineGitHosting::Config.get_setting(:gitolite_config_file))
      end


      def gitolite_config_dir
        dirs = File.dirname(gitolite_config_file).split('/')
        if dirs[0] != '.'
          File.join('conf', *dirs)
        else
          'conf'
        end
      end


      def gitolite_identifier_prefix
        RedmineGitHosting::Config.get_setting(:gitolite_identifier_prefix)
      end


      def gitolite_identifier_strip_user_id?
        RedmineGitHosting::Config.get_setting(:gitolite_identifier_strip_user_id, true)
      end


      def gitolite_key_subdir
        'redmine_git_hosting'
      end


      def git_config_username
        RedmineGitHosting::Config.get_setting(:git_config_username)
      end


      def git_config_email
        RedmineGitHosting::Config.get_setting(:git_config_email)
      end


      def gitolite_temp_dir
        RedmineGitHosting::Config.get_setting(:gitolite_temp_dir)
      end


      def gitolite_url
        [gitolite_user, '@', gitolite_server_host].join
      end


      def gitolite_admin_dir
        File.join(gitolite_temp_dir, gitolite_user, 'gitolite-admin.git')
      end


      def gitolite_log_level
        RedmineGitHosting::Config.get_setting(:gitolite_log_level)
      end

    end
  end
end
