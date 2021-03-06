#!/usr/bin/env ruby

#--

# Copyright 2003, 2004, 2005, 2006, 2007, 2008, 2009 by Peter Mounce (pete@neverrunwithscissors.com)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

#++
#
# = Rake DotNet -- A collection of custom tasks for .NET build automation
#
# This is the main file for Rake DotNet custom tasks.  Normally it is referenced
# as a library via a require statement, but it can be distributed
# independently as an application.

require 'rake'
require 'rake/tasklib'
require 'rake/clean'
require 'pathname'

desc "Displays this message; a list of tasks"
task :help do
	taskHash = Hash[*(`rake.cmd -T`.split(/\n/).collect { |l| l.match(/rake (\S+)\s+\#\s(.+)/).to_a }.collect { |l| [l[1], l[2]] }).flatten]

	indent = " "

	puts "rake #{indent}#Runs the 'default' task"

	taskHash.each_pair do |key, value|
		if key.nil?
			next
		end
		puts "rake #{key}#{indent.slice(0, indent.length - key.length)}##{value}"
	end
end

module RakeDotNet
