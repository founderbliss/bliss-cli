class ProjectAnalyzer
  attr_reader :directory
  attr_reader :total_lines

  def initialize(git_dir, max_lines = 750_000)
    @max_lines = max_lines
    update_directory(git_dir)
    calculate_total_lines
  end

  def update_directory(new_dir)
    @directory = new_dir
    calculate_total_lines
  end

  def too_big?
    return false if Gem.win_platform?
    @total_lines > @max_lines
  end

  def prompt_for_subdir(maindir = nil, git_dir = nil)
    return nil unless too_big?
    maindir = @directory if maindir.nil?
    git_dir = @directory if git_dir.nil?
    puts 'This repository appears to consist of multiple projects. ' \
    'Please choose a subdirectory to analyze (e.g. a node project, a rails project) or type exit.'
    full_subdir_path = choose_dir(maindir)
    if File.directory?(full_subdir_path)
      update_directory(full_subdir_path)
      return prompt_for_subdir(full_subdir_path, git_dir) if too_big?
      return full_subdir_path.gsub("#{git_dir}/", '')
    else
      puts 'Not a valid subdirectory.'.red
      prompt_for_subdir(maindir, git_dir)
    end
  end

  private

  def calculate_total_lines
    if @docker_loc
      @docker_loc.directory = @directory
    else
      @docker_loc = DockerLoc.new(@directory)
    end
    @total_lines = @docker_loc.run
  end

  def choose_dir(maindir)
    puts 'Possible choices:'
    Dir.glob("#{maindir}/*/").each do |sd|
      puts sd.gsub("#{maindir}/", '')
    end
    subdir = $stdin.gets.chomp
    subdir = subdir.strip
    exit if subdir =~ /exit/
    File.join(maindir, subdir)
  end
end
