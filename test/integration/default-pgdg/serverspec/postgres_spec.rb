require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('postgresql-9.6'), :if => os[:family] == 'ubuntu' || os[:family] == 'debian' do
  it { should be_installed }
end
describe package('postgresql96'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end
describe package('postgresql96-server'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('postgresql'), :if => os[:family] == 'ubuntu' || os[:family] == 'debian' do
  it { should be_enabled   }
  it { should be_running   }
end
describe service('postgresql-9.6'), :if => os[:family] == 'redhat' do
  it { should be_enabled   }
  it { should be_running   }
end

describe process("postgres") do
  its(:user) { should eq "postgres" }
## not on centos
#  its(:args) { should match /main\/postgresql.conf/ }
end

describe port(5432) do
  it { should be_listening }
end

describe file('/var/lib/postgresql/9.6/main'), :if => os[:family] == 'ubuntu' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.6/main'), :if => os[:family] == 'ubuntu' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.6/main/pg_hba.conf'), :if => os[:family] == 'ubuntu' do
  it { should be_file }
end
describe file('/usr/lib/postgresql/9.6/bin'), :if => os[:family] == 'ubuntu' do
  it { should be_directory }
end


describe file('/var/lib/pgsql/9.6'), :if => os[:family] == 'redhat' do
  it { should be_directory }
end
describe file('/var/lib/pgsql/9.6/data/pg_hba.conf'), :if => os[:family] == 'redhat' do
  it { should be_file }
end

