require_relative '../spec_helper'
RSpec.describe DockerRunner do
  before(:all) do
    env_vars = {
      'test_env' => 'testenv',
      'test_env_two' => 'testenvtwo'
    }
    @testdir = '/test/mytestrepodir'
    @docker_runner = DockerRunner.new(env_vars, @testdir, 'test/image', false)
  end

  it 'should have the correct command' do
    expected = "docker run -i -v #{@testdir}:/repos" \
    ' -e "TOP_LVL_DIR=/repositories" -e "test_env=testenv" -e "test_env_two=testenvtwo"' \
    ' --rm -t test/image ruby /root/collector/blisscollector.rb'
    expect(@docker_runner.docker_start_cmd).to eq(expected)
  end
end
