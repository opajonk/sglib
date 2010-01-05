function r=tensor_rank(T)
% TENSOR_RANK Returns the numerical rank of the given CP tensor.
%   R=TENSOR_RANK(T) returns the numerical rank R of the tensor, if the
%   tensor is in canonical format. If T is a full tensor, the number of
%   elements of the tensor are returned (which is a crude upper limit to
%   the tensor rank of T; actually you shouldn't call this method for a
%   full tensor).
%
% Example (<a href="matlab:run_example tensor_rank">run</a>)
%
% See also

%   Elmar Zander
%   Copyright 2010, Inst. of Scientific Comuting
%   $Id$ 
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version. 
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

if isfull(T)
    r=numel(T);
elseif iscanonical(T)
    r=size(T{1},2);
else
    error( 'tensor:tensor_rank:param_error', ...
        'input parameter is no recognized tensor format' );
end
