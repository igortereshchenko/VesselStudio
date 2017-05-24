function getFileSF

global hImage


files = uipickfiles('out','ch');
SF=size(files,1);
texte='';
for i=1:SF
	texte= strcat(texte,files(i,:));
	if i<SF
		texte=strcat(texte,';');
	end
end

	set(hImage, 'String', texte);
