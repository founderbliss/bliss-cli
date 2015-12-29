# Class to encapsulate docker commands
class DockerRunner
  def initialize(env_vars, repos_dir, image_name)
    @env_vars = env_vars
    @env_vars['TOP_LVL_DIR'] = '/repositories'
    @repos_dir = repos_dir
    @image_name = image_name
    build_image unless image_exists?
  end

  def run(command)
    `#{docker_start_cmd(command)}`
  end

  def docker_start_cmd(command)
    cmd = "docker -v #{@repos_dir}:/repositories"
    @env_vars.each do |k, v|
      cmd += " -e \"#{k}=#{v}\""
    end
    "#{cmd} --rm run -i -t #{@image_name} ruby ~/collector/blisscollector.rb #{command}"
  end

  def build_image
    `docker build -t #{@image_name} .`
  end

  def image_exists?
    `docker images`.include? @image_name
  end

  def self.remove_stopped
    `docker rm $(docker ps -a -q)`
  end
end
