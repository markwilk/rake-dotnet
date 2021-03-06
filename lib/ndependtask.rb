class NDependTask < Rake::TaskLib
	attr_accessor :options, :reports_dir, :dependencies

	def initialize(params={})
		@reports_dir = params[:reports_dir] || File.join(OUT_DIR, 'reports', 'ndepend')
		@dependencies = params[:dependencies] || []

		@options = params[:options] || {}
		@options[:reports_dir] = @reports_dir

		yield self if block_given?
		define
	end

	def define
		@dependencies.each do |d|
			task :ndepend => d
		end

		directory @reports_dir

		task :ndepend => [@reports_dir] do
			ndt = NDependConsoleCmd.new(:options => @options)
			ndt.run
		end

		task :clobber_ndepend do
			rm_rf @reports_dir
		end
	end
end
