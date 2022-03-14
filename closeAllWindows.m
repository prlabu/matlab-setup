% Close down all Variable Editor windows.
desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
Titles  = desktop.getClientTitles;
editorTabs = desktop.getGroupMembers('Editor'); 
for k = 1 : numel(Titles)
	Client = desktop.getClient(Titles(k));
	if ~isempty(Client)
		thisName = char(Client.getClass.getName);
		fprintf('Closing Variable Editor window for #%d = %s\n', k, thisName);
		% Close variable editor window.
		if contains(thisName, 'com.mathworks.mde.array.ArrayEditor')
			Client.close();
		end
	end
end