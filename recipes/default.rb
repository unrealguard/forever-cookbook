Chef::Log.info("*---------Forever Log-------------*")

include_recipe "nodejs::npm"

#-------------------------------------------------------#
Chef::Log.info("Installing forever globally with npm")

bash "install_forever" do
	code <<-BASH
		sudo npm install forever -g
		BASH
	not_if "test -f /usr/local/bin/forever"
end

#-------------------------------------------------------#

script_dir = node["forever"]["script_dir"]
script = node["forever"]["script"]

Chef::Log.info("Calling forever on script #{script_dir}/#{script}")

bash "start_forever" do
	cwd "#{script_dir}"
	code <<-BASH
		forever start -w -a -l forever.log -o out.log -e err.log #{script}
	BASH
end


Chef::Log.info("*---------Forever Log-------------*")