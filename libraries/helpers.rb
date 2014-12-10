#
# Cookbook Name:: krb5
# Library:: helpers
#
# Copyright © 2014 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# require 'rkerberos'

module Krb5
  # Helpers for Krb5
  module Helpers
    # Initialize Kadm5
    #
    # @return Object
    def kadm5_init(principal, password)
      Kerberos::Kadm5.new(:principal => principal, :password => password)
    end

    # Initialize Krb5
    #
    # @return Object
    def krb5_init
      Kerberos::Krb5.new
    end

    # Initialize Keytab
    #
    # @return Object
    def keytab_init
      Kerberos::Krb5::Keytab.new
    end

    # Verify admin credentials are passed
    def krb5_verify_admin
      Chef::Application.fatal!("You must specify both node['krb5']['admin_principal'] and node['krb5']['admin_password']!") if !node['krb5']['admin_principal'] || !node['krb5']['admin_password']
    end

    # Acquire credentials for principal from keytab using service
    # Parent method: #get_init_creds_keytab(principal = nil, keytab = nil, service = nil, ccache = nil)
    # If no principal, derive from service... If no service, defaults to "host"... If no keytab, defaults to "/etc/krb5.keytab"
    #
    # @result Object
    def krb5_kinit_keytab(principal, keytab)
      Kerberos::Krb5.get_init_creds_keytab(principal, keytab)
    end

    # Acquire credentials for user using password
    #
    # @result Object
    def krb5_kinit_password(user, password)
      Kerberos::Krb5.get_init_creds_password(user, password)
    end
  end
end

Chef::Recipe.send(:include, ::Krb5::Helpers)
Chef::Resource.send(:include, ::Krb5::Helpers)
Chef::Provider.send(:include, ::Krb5::Helpers)
