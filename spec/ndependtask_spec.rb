require 'spec'
require 'rake'
require 'rake/tasklib'
require File.join(File.dirname(__FILE__), '..', 'lib', 'ndependconsolecmd.rb')
require File.join(File.dirname(__FILE__), '..', 'lib', 'ndependtask.rb')
require 'constants_spec.rb'

describe NDependTask, 'When initialised with no settings' do
	before :all do
		@ndt = NDependTask.new
		@ndepend = Rake::Task[:ndepend]
		@reports_dir = Rake::FileTask['out/reports/ndepend']
		@clobber_ndepend = Rake::Task[:clobber_ndepend]
	end

	it 'should pass reports_dir to options for console runner' do
		@ndt.options.should include(:reports_dir)
		@ndt.reports_dir.should eql(@ndt.options[:reports_dir])
	end
	it 'should define a directory for reports' do
		@reports_dir.should_not be_nil
		@reports_dir.should be_a(Rake::FileTask)
		@reports_dir.name.should eql('out/reports/ndepend')
	end
	it 'should define an :ndepend task' do
		@ndepend.should_not be_nil
		@ndepend.should be_a(Rake::Task)
	end
	it 'should make :ndepend depend on @reports_dir' do
		@ndepend.prerequisites.should include('out/reports/ndepend')
	end
	it 'should define a :clobber_ndepend task' do
		@clobber_ndepend.should_not be_nil
		@clobber_ndepend.should be_a(Rake::Task)
	end
end

describe NDependTask, 'When initialised with reports_dir specified' do
	it 'should use it' do
		ndt = NDependTask.new(:reports_dir=>'foo')
		ndt.reports_dir.should eql('foo')
	end
end

describe NDependTask, 'When initialised with dependencies' do
	before :all do
		@ndt = NDependTask.new(:dependencies=>[:foo])
		@ndepend = Rake::Task[:ndepend]
	end
	it 'should read those dependencies' do
		@ndt.dependencies.should include(:foo)
	end
	it 'should make :ndepend task depend on those' do
		@ndepend.prerequisites.should include('foo')
	end
end
