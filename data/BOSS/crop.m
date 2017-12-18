files=glob('*.jpg');
for f=files'
    f=f{1};
    img=imread(f);
    min_extents=[2000 2000];
    max_extents = [1 1];
    
    
    mask = (img(:,:,1)<250) &  (img(:,:,2)<250) & (img(:,:,3)<250);
    for i=1:2000
        x=find(squeeze(mask(i,:)),1,'first');
        if ~isempty(x); min_extents(1)=min(min_extents(1),x); end;
        
        x=find(squeeze(mask(i,:)),1,'last');
        if ~isempty(x); max_extents(1)=max(max_extents(1), x); end;
        
        x=find(squeeze(mask(:,i)),1,'first');
        if ~isempty(x); min_extents(2)=min(min_extents(2), x); end;
        
        x=find(squeeze(mask(:,i)),1,'last');
        if ~isempty(x); max_extents(2)=max(max_extents(2),x ); end;
    end
    
    img2=img(min_extents(2):max_extents(2), min_extents(1):max_extents(1),:);
    imwrite(img2,['~/cropped/' f])
end


