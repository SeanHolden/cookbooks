# Cookbook:: postgresql
# Spec:: app_setup
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

require 'spec_helper'

describe 'postgresql::app_setup' do
  context 'When all attributes are default, on centos7' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version) do |node|
        node.normal['postgresql']['db_user'] = 'test_user'
        node.normal['postgresql']['db_password'] = 'password123'
        node.normal['postgresql']['db_name'] = 'test_db'
      end.converge(described_recipe)
    }
    let(:user_exists) { false }
    let(:db_exists) { false }
    let(:user_has_permissions) { false }

    before do
      stub_command("sudo -u postgres psql -c \"SELECT * FROM pg_user WHERE usename='test_user'\" | grep -c test_user").and_return(user_exists)
      stub_command("sudo -u postgres psql -c \"SELECT * FROM pg_database WHERE datname='test_db'\" | grep -c test_db").and_return(db_exists)
      stub_command("sudo -u postgres psql -c \"SELECT * FROM pg_database WHERE datname='test_db_test'\" | grep -c test_db_test").and_return(db_exists)
      stub_command("sudo -u postgres psql -c \"SELECT has_database_privilege('test_user', 'test_db', 'CREATE');\" | grep -c \"^ t$\"").and_return(user_has_permissions)
      stub_command("sudo -u postgres psql -c \"SELECT has_database_privilege('test_user', 'test_db_test', 'CREATE');\" | grep -c \"^ t$\"").and_return(user_has_permissions)
    end

    describe 'Create new psql user' do
      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "sudo -u postgres psql -c \"CREATE USER test_user WITH PASSWORD 'password123';\""
        ).with(user: 'root')
      end

      context 'user already exists on the db' do
        let(:user_exists) { true }

        it 'does not run command' do
          expect(chef_run).to_not run_execute("sudo -u postgres psql -c \"CREATE USER test_user WITH PASSWORD 'password123';\"")
        end
      end
    end

    describe 'Create new psql database' do
      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "sudo -u postgres psql -c \"CREATE DATABASE test_db;\""
        ).with(user: 'root')
      end

      context 'database already exists' do
        let(:db_exists) { true }

        it 'does not run command' do
          expect(chef_run).to_not run_execute(
            "sudo -u postgres psql -c \"CREATE DATABASE test_db;\""
          )
        end
      end
    end

    describe 'Create new psql test database' do
      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "sudo -u postgres psql -c \"CREATE DATABASE test_db_test;\""
        ).with(user: 'root')
      end

      context 'database already exists' do
        let(:db_exists) { true }

        it 'does not run command' do
          expect(chef_run).to_not run_execute(
            "sudo -u postgres psql -c \"CREATE DATABASE test_db_test;\""
          )
        end
      end
    end

    describe 'Grant privileges on database to user' do
      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE test_db to test_user\""
        ).with(user: 'root')
      end

      context 'user already has permissions granted' do
        let(:user_has_permissions) { true }

        it 'does not run command' do
          expect(chef_run).to_not run_execute("sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE test_db to test_user\"")
        end
      end
    end

    describe 'Grant privileges on test database to user' do
      it 'runs correct command' do
        expect(chef_run).to run_execute(
          "sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE test_db_test to test_user\""
        ).with(user: 'root')
      end

      context 'user already has permissions granted' do
        let(:user_has_permissions) { true }

        it 'does not run command' do
          expect(chef_run).to_not run_execute("sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE test_db_test to test_user\"")
        end
      end
    end
  end
end
