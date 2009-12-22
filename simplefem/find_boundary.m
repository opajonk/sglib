function bnd=find_boundary( els, points_only )

d=size(els,2)-1;
switch d
    case 1
        bnd=find_boundary_1d( els );
    case 2
        bnd=find_boundary_2d( els, points_only );
    otherwise
        error('simplefem:find_boundary:param_error', 'Unsupported dimension: %d. Maybe you have to pass your position vector transposed?', d);
end


function bnd=find_boundary_1d( els )
e=sort(els(:));
asnext=all(e(1:end-1,:)==e(2:end,:),2);
bndind=~([0;asnext]|[asnext;0]);
bnd=e(bndind,:);

function bnd=find_boundary_2d( els, points_only )
e=[els(:,1), els(:,2); els(:,1), els(:,3); els(:,2), els(:,3)];
e=sort(e,2);
e=sortrows(e);

asnext=all(e(1:end-1,:)==e(2:end,:),2);
bndind=~([0;asnext]|[asnext;0]);
bnd=e(bndind,:);
if points_only
    bnd=unique( bnd(:) );
end
