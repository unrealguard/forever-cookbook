

bash "install_forever" do
	code <<-EOH
		sudo npm install forever -g
		EOH
	not_if "type -p forever"
end