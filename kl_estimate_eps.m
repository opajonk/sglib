function [rem,params,sigma_ex]=kl_estimate_eps(sigma, varargin)
% KL_ESTIMATE_EPS Short description of kl_estimate_eps.
%   KL_ESTIMATE_EPS Long description of kl_estimate_eps.
%
% Example (<a href="matlab:run_example kl_estimate_eps">run</a>)
%
% See also

%   Elmar Zander
%   Copyright 2010, Inst. of Scientific Computing, TU Braunschweig
%   $Id$
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version.
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

options=varargin2options(varargin);
[N,options]=get_option(options,'N', 10000);
[skip,options]=get_option(options,'skip', max(10,floor(numel(sigma)/3)) );
[full,options]=get_option(options,'full', false );
[relrem,options]=get_option(options,'relrem', true );
[Nout,options]=get_option(options,'Nout', min(3*numel(sigma), N));
check_unsupported_options(options,mfilename);

sigma=sigma(:)';
n=length(sigma);

[a,b,c]=kl_best_fit(sigma, skip);
sigma_ex=kl_extrapolate( sigma, N, a, b, c );

rem=kl_remainder(sigma_ex,relrem);
if ~full
    rem=rem(n+1);
end

params=[a,b,c];
sigma_ex=kl_extrapolate( [], Nout, a, b, c );


function [a,b,c]=kl_best_fit( sigma, skip )
n1=skip+1;
n2=length(sigma);
s=log(sigma(n1:n2)');
e=ones(n2-n1+1,1);
k=(n1:n2)';
l=log(k);

abc=[e,l,-k]\s
s-[e,l,-k]*abc

a=exp(abc(1));
b=abc(2);
c=abc(3);


function rem=kl_remainder(sigma,rel)
rem=sum(sigma.^2)-[0 cumsum(sigma.^2)];
if rel
    rem=rem/sum(sigma.^2);
end

function eps=kl_eps( sigma, sigma_ex )
n=length(sigma);
N=length(sigma_ex);
S=sum(sigma_ex(n+1:N).^2);
s=sum(sigma.^2)+S;
eps=sqrt(S)/sqrt(s);

function sigma_ex=kl_extrapolate( sigma, N, a, b, c )
k=length(sigma)+1:N;
sigma_ex=[sigma, a*k.^b.*exp(-k*c)];





function plot_stuff( sigma, sigma_ex )
clf
subplot(3,1,1);
loglog(sigma); hold on
loglog(sigma_ex, 'r')

subplot(3,1,2);
semilogy(sigma); hold on
semilogy(sigma_ex, 'r')

subplot(3,1,3);
plot(sigma); hold on
plot(sigma_ex, 'r')
