function unittest_qr_internal
% UNITTEST_QR_INTERNAL Test the QR_INTERNAL function.
%
% Example (<a href="matlab:run_example unittest_qr_internal">run</a>)
%   unittest_qr_internal
%
% See also QR_INTERNAL, TESTSUITE 

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

munit_set_function( 'qr_internal' );

n=100;
k=40;
A=rand(n,k);
F=rand(n,n);
M=F'*F;

[Q,R]=qr_internal( A );
assert_equals( R, triu(R), 'qr_triu_R' );
assert_equals( Q'*Q, eye(k), 'qr_orth_Q' );
assert_equals( A, Q*R, 'qr_eq_A_QR' );

[Q,R]=qr_internal( A, M );
assert_equals( R, triu(R), 'cqr_triu_R' );
assert_equals( Q'*M*Q, eye(k), 'cqr_M_orth_Q' );
assert_equals( A, Q*R, 'cqr_eq_A_QR' );

%%
k2=30;
Q=orth( A );
B=rand(n,k2);
A=[Q*diag(rand(k,1)) B];
k=size(A,2);
korth=size(Q,2);

[Q,R]=qr_internal( A, [], korth );
assert_equals( R, triu(R), 'qroc_triu_R' );
assert_equals( Q'*Q, eye(k), 'qroc_orth_Q' );
assert_equals( A, Q*R, 'qroc_eq_A_QR' );

